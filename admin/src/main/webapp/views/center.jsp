<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Google Fonts 및 ZingChart 라이브러리 -->
<link href="https://fonts.googleapis.com/css?family=Crete+Round" rel="stylesheet">
<script src="https://cdn.zingchart.com/zingchart.min.js"></script>
<script src="https://cdn.zingchart.com/modules/zingchart-wordcloud.min.js"></script>

<!-- Highcharts 라이브러리 -->
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/data.js"></script>
<script src="https://code.highcharts.com/modules/drilldown.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>

<div class="content-body">
    <div class="container-fluid">

        <!-- 통계 영역 -->
        <div class="row">
            <div class="col-lg-3 col-sm-6">
                <div class="card shadow">
                    <div class="stat-widget-two card-body text-center">
                        <div class="stat-content">
                            <div class="stat-text" style="font-size: 1.2rem;">고객 수</div>
                            <div class="stat-digit mb-2" style="font-size: 2rem; font-weight: bold; color: #6B51DF; text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2);">648 명</div>
                        </div>
                        <a href="<c:url value='/customer-list'/>" class="btn btn-outline-primary btn-sm" style="border-color: #6B51DF;">고객 리스트 바로가기</a>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-sm-6">
                <div class="card shadow">
                    <div class="stat-widget-two card-body text-center">
                        <div class="stat-content">
                            <div class="stat-text" style="font-size: 1.2rem;">채팅 활성도</div>
                            <div class="stat-digit mb-2" style="font-size: 2rem; font-weight: bold; color: #28A745; text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2);">352 번</div>
                        </div>
                        <a href="<c:url value='/customer-chatlist'/>" class="btn btn-outline-success btn-sm" style="border-color: #28A745;">채팅 리스트 바로가기</a>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-sm-6">
                <div class="card shadow">
                    <div class="stat-widget-two card-body text-center">
                        <div class="stat-content">
                            <div class="stat-text" style="font-size: 1.2rem;">시니어 수</div>
                            <div class="stat-digit mb-2" style="font-size: 2rem; font-weight: bold; color: #FFC107; text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2);">612 명</div>
                        </div>
                        <a href="<c:url value='/senior-list'/>" class="btn btn-outline-warning btn-sm" style="border-color: #FFC107;">시니어 리스트 바로가기</a>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-sm-6">
                <div class="card shadow">
                    <div class="stat-widget-two card-body text-center">
                        <div class="stat-content">
                            <div class="stat-text" style="font-size: 1.2rem;">보호사 수</div>
                            <div class="stat-digit mb-2" style="font-size: 2rem; font-weight: bold; color: #DC3545; text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2);">452 명</div>
                        </div>
                        <a href="<c:url value='/careworker-list'/>" class="btn btn-outline-danger btn-sm" style="border-color: #DC3545;">보호사 리스트 바로가기</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- 서버 사용량 추이 -->
        <div class="row">
            <div class="col-12">
                <div class="card mb-4">
                    <div class="card-header">
                        <h4 class="card-title">서버 사용량 추이</h4>
                    </div>
                    <div class="card-body">
                        <div id="container1" style="height: 300px;"></div>
                    </div>
                    <div class="card-footer">
                        <form id="pollingForm" style="display: none;">
                            <div class="row mb-3">
                                <label for="fetchURL" class="col-sm-4 col-form-label">CSV URL:</label>
                                <div class="col-sm-8">
                                    <input type="text" id="fetchURL" class="form-control" value="https://demo-live-data.highcharts.com/time-data.csv" />
                                </div>
                            </div>
                            <div class="row mb-3 align-items-center">
                                <label for="enablePolling" class="col-sm-4 col-form-label">Enable Polling:</label>
                                <div class="col-sm-8">
                                    <div class="form-check">
                                        <input type="checkbox" id="enablePolling" class="form-check-input" checked />
                                        <label for="enablePolling" class="form-check-label">활성화</label>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <label for="pollingTime" class="col-sm-4 col-form-label">Polling Time (초):</label>
                                <div class="col-sm-8">
                                    <input type="number" id="pollingTime" class="form-control" value="1" />
                                </div>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
        </div>

        <!-- 차트 및 분석 영역 -->
        <div class="row">
            <div class="col-xl-6 col-lg-6 col-md-6">
                <div class="card">
                    <div class="card-header">
                        <h4 class="card-title">시니어 지역 분석</h4>
                    </div>
                    <div class="card-body">
                        <div id="seniorRegionChart" style="height: 300px;"></div>
                    </div>
                </div>
            </div>
            <div class="col-xl-6 col-lg-6 col-md-6">
                <div class="card">
                    <div class="card-header">
                        <h4 class="card-title">월별 매출</h4>
                    </div>
                    <div class="card-body">
                        <div id="monthlyRevenueChart" style="height: 300px;"></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 업셀링 및 추천 분석 -->
        <div class="row">
            <div class="col-xl-6 col-lg-6 col-md-6">
                <div class="card mb-4">
                    <div class="card-header text-center">
                        <h4 class="card-title">업셀링 및 추천 분석</h4>
                    </div>
                    <div class="card-body">
                        <div class="row text-center">
                            <div class="col-6">
                                <div class="info-box border p-3 rounded">
                                    <p class="info-title mb-2">추천 성공률</p>
                                    <p class="info-value text-primary mb-0"><strong>45%</strong></p>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="info-box border p-3 rounded">
                                    <p class="info-title mb-2">마케팅 기여율</p>
                                    <p class="info-value text-success mb-0"><strong>30%</strong></p>
                                </div>
                            </div>
                        </div>
                        <div class="row text-center mt-4">
                            <div class="col-12">
                                <div class="info-box border p-3 rounded">
                                    <p class="info-title mb-2">재계약 비율</p>
                                    <p class="info-value text-warning mb-0"><strong>47%</strong></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xl-6 col-lg-6 col-md-6">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h4 class="card-title mb-0">피드백 키워드 분석</h4>
                    </div>
                    <div class="card-body">
                        <div id="feedbackWordcloud" style="height: 400px;"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- ZingChart 및 Highcharts 스크립트 -->
<script>
    // 시니어 지역 차트 데이터
    const seniorRegionData = [
        { region: '서울', count: 142 },
        { region: '경기', count: 108 },
        { region: '부산', count: 82 },
        { region: '인천', count: 56 },
        { region: '대구', count: 48 },
        { region: '대전', count: 36 },
        { region: '광주', count: 20 },
        { region: '울산', count: 10 },
        { region: '세종', count: 18 },
        { region: '강원', count: 29 },
        { region: '충북', count: 14 },
        { region: '충남', count: 25 },
        { region: '전북', count: 10 },
        { region: '전남', count: 16 },
        { region: '경북', count: 15 },
        { region: '경남', count: 20 },
        { region: '제주', count: 7 },
    ];

    // Highcharts 시니어 지역 차트 생성
    Highcharts.chart('seniorRegionChart', {
        chart: {
            type: 'column'
        },
        title: {
            text: '지역별 시니어 수'
        },
        xAxis: {
            categories: seniorRegionData.map(data => data.region),
            title: {
                text: '지역'
            }
        },
        yAxis: {
            min: 0,
            title: {
                text: '시니어 수 (명)'
            }
        },
        tooltip: {
            pointFormat: '시니어 수: <b>{point.y}명</b>'
        },
        series: [{
            name: '시니어 수',
            data: seniorRegionData.map(data => data.count),
            color: '#17a2b8' // info 색상
        }]
    });

    // 케어워커 상태 차트 데이터
    var careworkerStatusData = {
        type: 'bar',
        series: [
            { values: [300], text: 'Active' },
            { values: [100], text: 'Inactive' },
            { values: [50], text: 'On Leave' },
        ]
    };

    // ZingChart 케어워커 상태 차트 생성
    zingchart.render({
        id: 'careworkerStatusChart',
        data: careworkerStatusData,
        height: '100%',
        width: '100%'
    });

    // 피드백 키워드 분석 워드클라우드 데이터
    // 피드백 키워드 분석 워드클라우드 데이터
    var feedbackData = [
        { text: "친절", count: 20 },
        { text: "응답 빠름", count: 15 },
        { text: "전문적", count: 10 },
        { text: "정확함", count: 8 },
        { text: "신속함", count: 12 },
        { text: "불친절", count: 5 },
        { text: "대기 시간 길음", count: 6 },
        { text: "비전문적", count: 4 },
        { text: "오류 빈번", count: 7 },
        { text: "불만족", count: 9 },
        { text: "응대 미흡", count: 3 },
        { text: "복잡함", count: 4 },
        { text: "사용자 친화적", count: 14 },
        { text: "깨끗함", count: 11 },
        { text: "가성비 좋음", count: 13 },
        { text: "편리함", count: 16 },
        { text: "소통 어려움", count: 5 },
        { text: "추천함", count: 18 },
        { text: "기대 이하", count: 7 },
        { text: "친절함 부족", count: 6 },
        { text: "효율적", count: 12 },
        { text: "시간 낭비", count: 4 },
        { text: "명확한 안내", count: 14 },
        { text: "비싸다", count: 3 },
        { text: "문제 해결 능력 부족", count: 5 },
        { text: "쾌적함", count: 13 },
        { text: "정돈된 환경", count: 10 },
        { text: "지연 발생", count: 6 },
        { text: "깔끔함", count: 15 },
        { text: "서비스 품질 높음", count: 17 },
        { text: "불만 처리 미흡", count: 4 },
        { text: "현대적", count: 9 },
        { text: "따뜻한 분위기", count: 11 },
        { text: "반복된 문제 발생", count: 3 },
        { text: "직원 태도 불만", count: 5 },
        { text: "정확한 정보 제공", count: 8 },
        { text: "친절하고 신속함", count: 19 },
        { text: "전문성 부족", count: 3 },
        { text: "불쾌감", count: 2 },
        { text: "편안함", count: 12 },
        { text: "깔끔한 인터페이스", count: 16 },
        { text: "불편함", count: 7 },
        { text: "강력 추천", count: 19 },
        { text: "반복 요청", count: 3 },
        { text: "적극적", count: 11 },
        { text: "성과 좋음", count: 14 },
        { text: "성의 부족", count: 5 }
    ];


    // ZingChart 피드백 워드클라우드 생성
    zingchart.render({
        id: 'feedbackWordcloud',
        data: {
            type: 'wordcloud',
            options: {
                words: feedbackData,
                palette: ['#1976D2', '#D32F2F', '#388E3C'],
            }
        },
        height: '100%',
        width: '100%'
    });
</script>
<script>
    Highcharts.chart('monthlyRevenueChart', {
        chart: { type: 'line' },
        title: { text: '월별 매출 추이' },
        xAxis: { categories: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'] },
        yAxis: { title: { text: '매출 (만원)' } },
        series: [{
            name: '매출',
            data: [500, 600, 550, 800, 750, 900, 950, 1000, 1200, 1100, 1050, 1250],
            color: '#FF5722'
        }]
    });
</script>
<script>
    const defaultData = 'https://demo-live-data.highcharts.com/time-data.csv';
    const urlInput = document.getElementById('fetchURL');
    const pollingCheckbox = document.getElementById('enablePolling');
    const pollingInput = document.getElementById('pollingTime');

    function createChart() {
        Highcharts.chart('container1', {
            chart: {
                type: 'line'
            },
            title: {
                text: ''
            },
            accessibility: {
                announceNewData: {
                    enabled: true,
                    minAnnounceInterval: 15000,
                    announcementFormatter: function (
                        allSeries,
                        newSeries,
                        newPoint
                    ) {
                        if (newPoint) {
                            return `새 데이터 추가됨: ${newPoint.y}`;
                        }
                        return false;
                    }
                }
            },
            plotOptions: {
                line: {
                    color: '#007BFF',
                    marker: {
                        lineWidth: 1,
                        lineColor: null,
                        fillColor: 'white'
                    }
                }
            },
            data: {
                csvURL: urlInput.value,
                enablePolling: pollingCheckbox.checked === true,
                dataRefreshRate: parseInt(pollingInput.value, 10)
            }
        });

        if (pollingInput.value < 1 || !pollingInput.value) {
            pollingInput.value = 1;
        }
    }

    urlInput.value = defaultData;

    pollingCheckbox.onchange = urlInput.onchange = pollingInput.onchange = createChart;

    createChart();

</script>