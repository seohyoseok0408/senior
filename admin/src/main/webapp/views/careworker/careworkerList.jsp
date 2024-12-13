<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    tbody tr td {
        color: black; /* 기본 글자 색상을 검정으로 설정 */
        font-size: 10px; /* 원하는 글자 크기로 조정 */
    }

    tbody tr:hover td {
        color: #3043c7; /* 마우스를 올렸을 때 글자 색상을 파란색으로 설정 */
    }
</style>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>

<div class="content-body">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-6 col-sm-6">
                <figure class="highcharts-figure">
                    <div id="container1"></div>
                </figure>
            </div>
            <div class="col-lg-6 col-sm-6">
                <figure class="highcharts-figure">
                    <div id="container2"></div>
                </figure>
            </div>
        </div>
        <h1>현재 승인된 보호사 리스트</h1>
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <div class="table-responsive">
                        <table id="example" class="display" style="min-width: 845px">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Tel</th>
                                <th>Email</th>
                                <th>Gender</th>
                                <th>Status</th>
                                <th>Street Address</th>
                                <th>Detail Address</th>
                                <th>Experience</th>
                            </tr>
                            </thead>
                            <tbody>
                            <!-- 데이터 행들 -->
                            <c:forEach var="careworker" items="${user}">
                                <tr onclick="window.location.href='careworker-detail?id=${careworker.cwId}'" style="cursor: pointer;">
                                    <td>${careworker.cwId}</td>
                                    <td>${careworker.cwName}</td>
                                    <td>${careworker.cwTel}</td>
                                    <td>${careworker.cwEmail}</td>
                                    <td>${careworker.cwGender}</td>
                                    <td>${careworker.cwStatus}</td>
                                    <td>${careworker.cwStreetAddr}</td>
                                    <td>${careworker.cwDetailAddr1}</td>
                                    <td>${careworker.cwExperience}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Required vendors -->
<script src="./vendor/global/global.min.js"></script>
<script src="./js/quixnav-init.js"></script>
<script src="./js/custom.min.js"></script>

<!-- Datatable -->
<script src="./vendor/datatables/js/jquery.dataTables.min.js"></script>
<script src="./js/plugins-init/datatables.init.js"></script>
<script>
    // JSP에서 모델 데이터를 JavaScript로 변환
    const careworkerStatusData = ${careworkerStatusCounts};

    // 보호사 상태 데이터 변환
    const careworkerStatusChartData = careworkerStatusData.map(status => ({
        name: status.cw_status.charAt(0).toUpperCase() + status.cw_status.slice(1),
        y: status.count
    }));

    // 보호사 상태별 차트 렌더링
    Highcharts.chart('container1', {
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            type: 'pie'
        },
        title: {
            text: '보호사 상태별 분포',
            align: 'left'
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        accessibility: {
            point: {
                valueSuffix: '%'
            }
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                colors: Highcharts.getOptions().colors,
                borderRadius: 5,
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                    distance: -50,
                    filter: {
                        property: 'percentage',
                        operator: '>',
                        value: 4
                    }
                }
            }
        },
        series: [{
            name: 'Careworker Status',
            colorByPoint: true,
            data: careworkerStatusChartData
        }]
    });
</script>


<script>
    // 월별 평균 평점 데이터를 JSP에서 전달받아 파싱
    const monthlyAverageRatings = JSON.parse('${monthlyAverageRatings}');

    // 데이터를 Highcharts 형식으로 변환
    const categories = monthlyAverageRatings.map(data => data.Month); // x축 (월)
    const data = monthlyAverageRatings.map(data => parseFloat(data.average_rating)); // y축 (평점)

    // Highcharts 차트 설정
    Highcharts.chart('container2', {
        chart: {
            type: 'line'
        },
        title: {
            text: '월별 평균 서비스 평점'
        },
        xAxis: {
            categories: categories, // x축에 월 표시
            title: {
                text: '월'
            }
        },
        yAxis: {
            min: 0,
            max: 5,
            title: {
                text: '평균 평점'
            },
            tickInterval: 1
        },
        series: [{
            name: '평균 평점',
            data: data, // y축 데이터
            marker: {
                symbol: 'circle'
            }
        }],
        tooltip: {
            headerFormat: '<b>{point.key}</b><br/>',
            pointFormat: '{series.name}: {point.y}'
        },
        credits: {
            enabled: false
        }
    });
</script>
Q