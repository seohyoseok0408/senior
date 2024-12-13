<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
                    <div id="container"></div>
                </figure>
            </div>
        </div>
        <h1>유저 리스트</h1>
        <div class="col-12">
            <div class="card">
                <div class="card-body">
                    <div class="table-responsive">
                        <table id="example" class="display" style="min-width: 845px">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>Username</th>
                                <th>Tel</th>
                                <th>Email</th>
                                <th>Status</th>
                            </tr>
                            </thead>
                            <tbody>
                            <!-- 데이터 행들 -->
                            <c:forEach var="user" items="${user}">
                                <tr onclick="window.location.href='customer-detail?id=${user.userId}'"
                                    style="cursor: pointer;">
                                    <td>${user.userId}</td>
                                    <td>${user.userName}</td>
                                    <td>${user.userTel}</td>
                                    <td>${user.userEmail}</td>
                                    <td>${user.userStatus}</td>
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
    const userStatusData = ${userStatusRatio};
    const signupTrendsData = ${signupTrends};

    // 고객 Active / Inactive 비율 데이터 변환
    const userStatusChartData = userStatusData.map(status => ({
        name: status.user_status.charAt(0).toUpperCase() + status.user_status.slice(1),
        y: status.count
    }));

    // 신규 가입자 추이 데이터 변환
    const signupTrendsChartData = signupTrendsData.map(item => ({
        month: item.signup_month,
        count: item.signup_count
    }));

    // 고객 Active / Inactive 비율 차트 렌더링 (container1)
    Highcharts.chart('container1', {
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            type: 'pie'
        },
        title: {
            text: '고객 Active / Inactive 비율',
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
                    format: '<b>{point.name}</b><br>{point.percentage:.1f} %',
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
            name: 'User Status',
            colorByPoint: true,
            data: userStatusChartData
        }]
    });

    // 12개월 신규 가입자 추이 차트 렌더링 (container)
    Highcharts.chart('container', {
        chart: {
            type: 'column'
        },
        title: {
            text: '12개월 신규 가입자 추이'
        },
        xAxis: {
            categories: signupTrendsChartData.map(data => data.month), // 월 목록
            title: {
                text: '월'
            }
        },
        yAxis: {
            min: 0,
            title: {
                text: '가입자 수'
            }
        },
        tooltip: {
            pointFormat: '가입자 수: <b>{point.y}</b>'
        },
        series: [{
            name: '가입자 수',
            data: signupTrendsChartData.map(data => data.count) // 가입자 수 데이터
        }]
    });
</script>
