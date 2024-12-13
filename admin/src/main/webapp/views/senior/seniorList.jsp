<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    tbody tr td {
        color: black;
        font-size: 10px;
    }

    tbody tr:hover td {
        color: #3043c7;
    }
</style>

<div class="content-body">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-6 col-sm-6">
                <div id="container1"></div>
                <script src="https://code.highcharts.com/maps/highmaps.js"></script>
                <script src="https://code.highcharts.com/maps/modules/data.js"></script>
                <script src="https://code.highcharts.com/maps/modules/drilldown.js"></script>
                <script src="https://code.highcharts.com/maps/modules/exporting.js"></script>
                <script src="https://code.highcharts.com/maps/modules/offline-exporting.js"></script>
                <script src="https://code.highcharts.com/maps/modules/accessibility.js"></script>

            </div>
            <div class="col-lg-6 col-sm-6">
                <div id="container2"></div>
                <p class="highcharts-description">
                    Bar chart showing Andorran population distribution by using a mirrored
                    horizontal column chart with stacking and two x-axes.
                </p>
                <script src="https://code.highcharts.com/maps/highmaps.js"></script>
                <script src="https://code.highcharts.com/maps/modules/data.js"></script>
                <script src="https://code.highcharts.com/maps/modules/drilldown.js"></script>
                <script src="https://code.highcharts.com/maps/modules/exporting.js"></script>
                <script src="https://code.highcharts.com/maps/modules/offline-exporting.js"></script>
                <script src="https://code.highcharts.com/maps/modules/accessibility.js"></script>

            </div>
        </div>

    </div>

    <div class="col-12">
        <h1>시니어 리스트</h1>
        <div class="card">
            <div class="card-body">
                <div class="table-responsive">
                    <table id="example" class="display" style="min-width: 845px">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Gender</th>
                            <th>Tel</th>
                            <th>Birth</th>
                            <th>Status</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="senior" items="${seniors}">
                            <tr onclick="window.location.href='senior-detail?id=${senior.seniorId}'"
                                style="cursor: pointer;">
                                <td>${senior.seniorId}</td>
                                <td>${senior.seniorName}</td>
                                <td>${senior.seniorGender}</td>
                                <td>${senior.seniorTel}</td>
                                <td>${senior.seniorBirth}</td>
                                <td>${senior.seniorStatus}</td>
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

<!-- Datatable -->
<script src="./vendor/datatables/js/jquery.dataTables.min.js"></script>
<script src="./js/plugins-init/datatables.init.js"></script>
<script>

    const regionNames = {
        "Seoul": "서울",
        "Busan": "부산",
        "Incheon": "인천",
        "Daegu": "대구",
        "Daejeon": "대전",
        "Gwangju": "광주",
        "Ulsan": "울산",
        "Sejong": "세종",
        "Gyeonggi": "경기",
        "Gangwon": "강원",
        "North Chungcheong": "충북",
        "South Chungcheong": "충남",
        "North Jeolla": "전북",
        "South Jeolla": "전남",
        "North Gyeongsang": "경북",
        "South Gyeongsang": "경남",
        "Jeju": "제주"
    };

    const drilldown = async function (e) {
        if (!e.seriesOptions) {
            const chart = this,
                mapKey = `countries/kr/${e.point.drilldown}-all`;

            let fail = setTimeout(() => {
                if (!Highcharts.maps[mapKey]) {
                    chart.showLoading(`
                    <i class="icon-frown"></i>
                    Failed loading ${e.point.name}
                `);
                    fail = setTimeout(() => {
                        chart.hideLoading();
                    }, 1000);
                }
            }, 3000);

            chart.showLoading('<i class="icon-spinner icon-spin icon-3x"></i>');

            const topology = await fetch(
                `https://code.highcharts.com/mapdata/${mapKey}.topo.json`
            ).then(response => response.json());

            const data = Highcharts.geojson(topology);

            data.forEach((d, i) => {
                d.value = i;
            });

            chart.mapView.update(
                Highcharts.merge(
                    {
                        insets: undefined,
                        padding: 0
                    },
                    topology.objects.default['hc-recommended-mapview']
                )
            );

            chart.hideLoading();
            clearTimeout(fail);
            chart.addSeriesAsDrilldown(e.point, {
                name: e.point.name,
                data,
                dataLabels: {
                    enabled: true,
                    format: '{point.name}'
                }
            });
        }
    };

    const afterDrillUp = function (e) {
        if (e.seriesOptions.custom && e.seriesOptions.custom.mapView) {
            e.target.mapView.update(
                Highcharts.merge(
                    { insets: undefined },
                    e.seriesOptions.custom.mapView
                ),
                false
            );
        }
    };
    const regionWisePersonCount = JSON.parse('${regionWisePersonCountJson}');
    console.log(regionWisePersonCount); // 데이터 확인
    (async () => {
        const topology = await fetch(
            'https://code.highcharts.com/mapdata/countries/kr/kr-all.topo.json'
        ).then(response => response.json());

        const data = Highcharts.geojson(topology);

        const mapView = topology.objects.default['hc-recommended-mapview'];

        const personCountMapping = {};
        regionWisePersonCount.forEach(item => {
            personCountMapping[item.region_name] = item.person_count;
        });

        data.forEach(d => {
            const englishName = d.properties.name;
            if (regionNames[englishName]) {
                d.properties.name = regionNames[englishName];
                d.value = personCountMapping[regionNames[englishName]] || 0;
            } else {
                d.value = 0;
            }
        });

        Highcharts.mapChart('container1', {
            chart: { events: { drilldown, afterDrillUp } },
            title: { text: '지역별 시니어 인원수' },
            colorAxis: { min: 0, minColor: '#F7F7F7', maxColor: '#6B51DF' },
            mapView,
            mapNavigation: { enabled: true, buttonOptions: { verticalAlign: 'bottom' } },
            tooltip: {
                headerFormat: '',
                pointFormat: '{point.properties.name}: {point.value}'
            },
            series: [{
                data,
                name: '지역별 인원수',
                dataLabels: {
                    enabled: false // 기본적으로 데이터 라벨 비활성화
                },
                states: {
                    hover: {
                        enabled: true,
                        halo: {
                            size: 10 // 마우스 오버 효과
                        }
                    }
                },
                point: {
                    events: {
                        mouseOver: function () {
                            // 마우스 오버 시 해당 지역 이름 표시
                            this.update({
                                dataLabels: {
                                    enabled: true,
                                    format: '{point.properties.name}'
                                }
                            });
                        },
                        mouseOut: function () {
                            // 마우스 아웃 시 이름 숨기기
                            this.update({
                                dataLabels: {
                                    enabled: false
                                }
                            });
                        }
                    }
                }
            }]
        });
    })();
</script>
<script>
    // 서버에서 전달받은 JSON 데이터를 JavaScript 변수로 변환
    const ageGroupDistribution = JSON.parse('${ageGroupDistributionJson}');

    // 카테고리 및 시리즈 데이터를 생성
    const categories = ageGroupDistribution.map(data => data.age_group);
    const maleData = ageGroupDistribution.map(data => -data.male_count); // 음수로 변환 (Population Pyramid 스타일)
    const femaleData = ageGroupDistribution.map(data => data.female_count);

    // Highcharts 차트 생성
    Highcharts.chart('container2', {
        chart: {
            type: 'bar'
        },
        title: {
            text: 'Age Group Distribution',
            align: 'left'
        },
        subtitle: {
            text: 'Source: Senior Data',
            align: 'left'
        },
        accessibility: {
            point: {
                valueDescriptionFormat: '{index}. Age {xDescription}, {value} people.'
            }
        },
        xAxis: [{
            categories: categories,
            reversed: false,
            labels: {
                step: 1
            },
            accessibility: {
                description: 'Age (male)'
            }
        }, { // mirror axis on right side
            opposite: true,
            reversed: false,
            categories: categories,
            linkedTo: 0,
            labels: {
                step: 1
            },
            accessibility: {
                description: 'Age (female)'
            }
        }],
        yAxis: {
            title: {
                text: null
            },
            labels: {
                formatter: function () {
                    return Math.abs(this.value); // 절대값 표시
                }
            },
            accessibility: {
                description: 'Number of people',
                rangeDescription: 'Range: 0 to max population'
            }
        },

        plotOptions: {
            series: {
                stacking: 'normal',
                borderRadius: '5%'
            }
        },

        tooltip: {
            pointFormat: '<b>{series.name}, age {point.category}</b><br/>' +
                'Population: {point.y:.0f} people'
        },

        series: [{
            name: 'Male',
            data: maleData,
            color: '#4682B4' // 차분한 파란색
        }, {
            name: 'Female',
            data: femaleData,
            color: '#FF69B4' // 부드러운 분홍색
        }]
    });
</script>
