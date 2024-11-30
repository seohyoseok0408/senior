<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Senior Health Data Charts</title>
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/accessibility.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .highcharts-figure {
            min-width: 320px;
            max-width: 800px;
            margin: 1em auto;
            padding: 10px;
        }
        .chart {
            height: 220px;
        }
        .header {
            background-color: #f8f9fa;
            padding: 1em;
            text-align: center;
        }
        .footer {
            background-color: #f8f9fa;
            padding: 1em;
            text-align: center;
            position: fixed;
            bottom: 0;
            width: 100%;
        }
        .content {
            padding: 2em;
        }
    </style>
</head>
<body>
<!-- Header -->
<header class="header">
    <h1>Health Data Chart</h1>
</header>

<!-- Main Content -->
<div class="content">
    <figure class="highcharts-figure">
        <div id="container"></div>
    </figure>
</div>

<!-- Footer -->
<footer class="footer">
    <p>&copy; 2024 Senior Health Monitoring</p>
</footer>

<script>
    // JSP에서 전달된 데이터와 ID를 가져오기
    const seniorId = "${seniorId}";
    let healthData = JSON.parse('${healthData}'.replace(/&quot;/g, '"'));
    console.log("Initial Health Data:", healthData);

    const chartTitles = ['Systolic BP', 'Diastolic BP', 'Heart Rate', 'Temperature'];
    const chartColors = ['#FF5733', '#33FF57', '#3357FF', '#FFC300']; // 차트별 고유 색상
    const chartSeries = [];
    const charts = [];

    // 차트 초기화
    chartTitles.forEach((title, index) => {
        const chartDiv = document.createElement('div');
        chartDiv.className = 'chart';
        document.getElementById('container').appendChild(chartDiv);

        charts[index] = Highcharts.chart(chartDiv, {
            chart: {
                marginLeft: 40,
                spacingTop: 20,
                spacingBottom: 20,
                zooming: {
                    type: 'x'
                }
            },
            title: {
                text: title,
                align: 'left',
                margin: 0,
                x: 30
            },
            credits: {
                enabled: false
            },
            legend: {
                enabled: false
            },
            xAxis: {
                type: 'datetime',
                crosshair: true,
                labels: {
                    format: '{value:%Y-%m-%d %H:%M:%S}' // 년/월/일 시:분:초 형식
                },
                title: {
                    text: 'Time'
                }
            },
            yAxis: {
                title: {
                    text: null
                }
            },
            tooltip: {
                shared: true,
                xDateFormat: '%Y-%m-%d %H:%M:%S', // 툴팁에서도 동일하게 표시
                pointFormat: '{point.y}'
            },
            series: [{
                name: title,
                data: [],
                color: chartColors[index] // 각 차트에 고유 색상 지정
            }]
        });

        chartSeries.push(charts[index].series[0]);
    });

    // 초기 데이터로 차트를 렌더링
    function renderInitialData() {
        if (healthData && healthData.length > 0) {
            const latestData = healthData.slice(-5); // 최신 5개 데이터만 표시
            latestData.forEach(entry => {
                const time = new Date(entry.timestamp + " UTC").getTime();
                chartSeries[0].addPoint([time, entry.systolicBP], false);
                chartSeries[1].addPoint([time, entry.diastolicBP], false);
                chartSeries[2].addPoint([time, entry.heartRate], false);
                chartSeries[3].addPoint([time, entry.temperature], false);
            });
            charts.forEach(chart => chart.redraw());
        } else {
            document.getElementById('container').innerHTML = "<p>No data available for this senior.</p>";
        }
    }

    renderInitialData();

    // AJAX 요청을 통해 데이터 갱신
    function fetchDataAndUpdateCharts() {
        $.ajax({
            url: `/iot/health/${seniorId}/data`, // JSON 데이터를 반환하는 경로
            method: 'GET',
            dataType: 'json',
            success: function (response) {
                console.log("Received data:", response);

                if (response && response.length > 0) {
                    const latestEntry = response[response.length - 1]; // 최신 데이터 1개
                    const time = new Date(latestEntry.timestamp + " UTC").getTime();

                    // 각 차트의 시리즈 업데이트 (최신 데이터 추가, 기존 데이터 유지)
                    chartSeries.forEach((series, index) => {
                        const newValue = index === 0
                            ? latestEntry.systolicBP
                            : index === 1
                                ? latestEntry.diastolicBP
                                : index === 2
                                    ? latestEntry.heartRate
                                    : latestEntry.temperature;

                        // 데이터를 추가하지만 X축은 최대 5개까지만 유지
                        if (series.data.length >= 5) {
                            series.data[0].remove(); // 가장 오래된 데이터 제거
                        }
                        series.addPoint([time, newValue], true); // 최신 데이터 추가
                    });
                }
            },
            error: function (xhr, status, error) {
                console.error("Error fetching data:", status, error);
            }
        });
    }

    // 2초마다 데이터 갱신
    setInterval(fetchDataAndUpdateCharts, 2000);
</script>

</body>
</html>
