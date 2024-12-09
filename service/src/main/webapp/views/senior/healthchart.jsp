<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>시니어 건강 데이터</title>
  <script src="https://code.highcharts.com/highcharts.js"></script>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <style>
    .chart-container {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
    }
    .chart {
      width: 45%;
      margin: 10px;
    }
    .filter {
      text-align: center;
      margin-bottom: 20px;
    }
       /* 차트 컨테이너 스타일 */
     .chart-container {
       display: flex;
       flex-wrap: wrap;
       justify-content: center;
       gap: 20px; /* 차트 간 간격 */
       margin-top: 20px;
       padding: 10px;
     }

    .chart {
      width: 45%;
      min-height: 300px; /* 차트의 최소 높이 지정 */
      background-color: #fff; /* 차트 배경 흰색 */
      border: 1px solid #ddd;
      border-radius: 10px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      padding: 10px;
    }

    /* 필터 영역 스타일 */
    .filter {
      display: flex;
      justify-content: center;
      align-items: center;
      gap: 10px; /* 요소 간 간격 */
      margin-bottom: 30px;
      padding: 10px;
      background-color: #f9f9f9;
      border-radius: 10px;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }

    .filter label {
      font-size: 18px;
      font-weight: bold;
      color: #333;
    }

    .filter input[type="date"] {
      padding: 8px 12px;
      font-size: 16px;
      border: 1px solid #ccc;
      border-radius: 5px;
      box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
      transition: border-color 0.3s ease;
    }

    .filter input[type="date"]:focus {
      outline: none;
      border-color: #4CAF50;
    }

    .filter button {
      padding: 10px 20px;
      font-size: 16px;
      font-weight: bold;
      color: white;
      background-color: #4CAF50;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      transition: background-color 0.3s ease, transform 0.2s ease;
    }

    .filter button:hover {
      background-color: #45a049;
      transform: translateY(-2px);
    }

    .filter button:active {
      background-color: #3e8e41;
      transform: translateY(0);
    }

    /* 제목 스타일 */
    h1 {
      text-align: center;
      font-size: 28px;
      font-weight: bold;
      color: #4CAF50;
      margin-bottom: 20px;
    }
  </style>

<body>
<h1>시니어 건강 데이터</h1>

<!-- 필터 영역 -->
<div class="filter">
  <label for="datePicker">날짜 선택:</label>
  <input type="date" id="datePicker">
  <button onclick="filterData()">확인</button>
</div>

<!-- 차트 컨테이너 -->
<div class="chart-container">
  <div id="chart-systolic" class="chart"></div>
  <div id="chart-diastolic" class="chart"></div>
  <div id="chart-heart" class="chart"></div>
  <div id="chart-temperature" class="chart"></div>
</div>


<script>
  let fullData = []; // 전체 데이터를 저장할 배열
  let selectedDateRange = { min: null, max: null }; // 선택한 날짜 범위를 저장

  // 차트 초기화
  function initializeChart(containerId, title, seriesName, color, yAxisTitle) {
    return Highcharts.chart(containerId, {
      chart: {
        type: 'line',
        events: {
          load: function () {
            addMouseWheelZoom(this); // 마우스 휠 줌 추가
          }
        }
      },
      title: { text: title },
      xAxis: {
        type: 'datetime',
        title: { text: null },
        crosshair: true // 마우스 오버 시 세부 데이터 표시
      },
      yAxis: { title: { text: yAxisTitle } },
      series: [{
        name: seriesName,
        data: [],
        color: color,
        cursor: 'pointer', // 클릭 가능하도록 설정
        point: {
          events: {
            click: function () {
              zoomToPoint(this.series.chart, this.x); // 클릭 시 줌 설정
            }
          }
        }
      }],
      tooltip: {
        shared: true,
        xDateFormat: '%Y-%m-%d %H:%M:%S', // 날짜 툴팁 포맷
        pointFormat: '{series.name}: {point.y}'
      },
      credits: { enabled: false } // Highcharts 로고 비활성화
    });
  }

  const systolicChart = initializeChart('chart-systolic', '수축기 혈압', '수축기 혈압', '#FF5733', '혈압 (mmHg)');
  const diastolicChart = initializeChart('chart-diastolic', '이완기 혈압', '이완기 혈압', '#33FF57', '혈압 (mmHg)');
  const heartRateChart = initializeChart('chart-heart', '심박수', '심박수', '#3357FF', '심박수 (bpm)');
  const temperatureChart = initializeChart('chart-temperature', '체온', '체온', '#FFC300', '체온 (°C)');

  // 마우스 휠 줌인/줌아웃 추가
  function addMouseWheelZoom(chart) {
    const container = chart.container;
    container.addEventListener('wheel', function (event) {
      event.preventDefault();

      const xAxis = chart.xAxis[0];
      const extremes = xAxis.getExtremes();
      const delta = event.deltaY > 0 ? 1.2 : 0.8; // 줌 방향 계산 (줌인: 0.8, 줌아웃: 1.2)

      let newMin = extremes.min + (extremes.max - extremes.min) * (1 - delta) / 2;
      let newMax = extremes.max - (extremes.max - extremes.min) * (1 - delta) / 2;

      // 선택한 날짜 범위 내에서만 줌인/줌아웃 가능
      newMin = Math.max(newMin, selectedDateRange.min);
      newMax = Math.min(newMax, selectedDateRange.max);

      xAxis.setExtremes(newMin, newMax);
    });
  }

  // 특정 점을 기준으로 줌인
  function zoomToPoint(chart, pointX) {
    const xAxis = chart.xAxis[0];
    const extremes = xAxis.getExtremes();

    const zoomRange = (extremes.max - extremes.min) / 4; // 줌 범위
    const newMin = Math.max(pointX - zoomRange / 2, selectedDateRange.min);
    const newMax = Math.min(pointX + zoomRange / 2, selectedDateRange.max);

    xAxis.setExtremes(newMin, newMax);
  }

  // 데이터 가져오기
  function loadData() {
    $.ajax({
      url: `/iot/health/${seniorId}`, // 시니어 ID는 예시
      method: 'GET',
      success: function (response) {
        fullData = response;
      },
      error: function (xhr, status, error) {
        console.error("데이터 로드 실패:", error);
      }
    });
  }

  // 차트 데이터 렌더링
  function renderCharts(data) {
    const systolicData = data.map(entry => [new Date(entry.timestamp + " UTC").getTime(), entry.systolicBP]);
    const diastolicData = data.map(entry => [new Date(entry.timestamp + " UTC").getTime(), entry.diastolicBP]);
    const heartRateData = data.map(entry => [new Date(entry.timestamp + " UTC").getTime(), entry.heartRate]);
    const temperatureData = data.map(entry => [new Date(entry.timestamp + " UTC").getTime(), entry.temperature]);

    systolicChart.series[0].setData(systolicData);
    diastolicChart.series[0].setData(diastolicData);
    heartRateChart.series[0].setData(heartRateData);
    temperatureChart.series[0].setData(temperatureData);
  }

  // 날짜 필터링
  function filterData() {
    const selectedDate = document.getElementById('datePicker').value;
    if (!selectedDate) {
      alert('날짜를 선택하세요!');
      return;
    }

    const filteredData = fullData.filter(entry => {
      const entryDate = new Date(entry.timestamp + " UTC").toISOString().split('T')[0];
      return entryDate === selectedDate;
    });

    if (filteredData.length === 0) {
      alert('선택한 날짜에 데이터가 없습니다.');
      renderCharts([]);
      selectedDateRange = { min: null, max: null };
    } else {
      renderCharts(filteredData);

      const timestamps = filteredData.map(entry => new Date(entry.timestamp + " UTC").getTime());
      selectedDateRange = { min: Math.min(...timestamps), max: Math.max(...timestamps) };

      systolicChart.xAxis[0].setExtremes(selectedDateRange.min, selectedDateRange.max);
      diastolicChart.xAxis[0].setExtremes(selectedDateRange.min, selectedDateRange.max);
      heartRateChart.xAxis[0].setExtremes(selectedDateRange.min, selectedDateRange.max);
      temperatureChart.xAxis[0].setExtremes(selectedDateRange.min, selectedDateRange.max);
    }
  }

  loadData(); // 초기 데이터 로드
</script>
</body>
</html>