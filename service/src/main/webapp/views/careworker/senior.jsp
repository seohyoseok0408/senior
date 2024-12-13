<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap');

    :root {
        --primary: #2ecc71;
        --primary-light: #e8f8f5;
        --secondary: #27ae60;
        --background: #f9f9f9;
        --text: #2c3e50;
        --text-light: #7f8c8d;
        --border: #a5d6a7;
        --white: #ffffff;
        --shadow: 0 4px 6px rgba(46, 204, 113, 0.1);
        --transition: all 0.3s ease;
    }

    body {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: var(--background);
        color: var(--text);
        line-height: 1.6;
        margin: 0;
        padding: 0;
    }

    .container {
        max-width: 1400px;
        margin: 0 auto;
        padding: 2rem;
    }

    .dashboard {
        display: grid;
        grid-template-columns: 1fr 2fr;
        gap: 2rem;
    }

    .card {
        background: var(--white);
        border-radius: 20px;
        box-shadow: var(--shadow);
        overflow: hidden;
        transition: var(--transition);
    }

    .card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 15px rgba(46, 204, 113, 0.2);
    }

    .card-header {
        background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
        color: var(--white);
        padding: 1.5rem 2rem;
        font-size: 1.5rem;
        font-weight: 700;
        text-align: center;
    }

    .card-body {
        padding: 2rem;
    }

    .profile-section {
        display: flex;
        flex-direction: column;
        align-items: center;
        text-align: center;
    }

    .profile-image {
        width: 200px;
        height: 200px;
        border-radius: 50%;
        object-fit: cover;
        border: 5px solid var(--primary);
        box-shadow: var(--shadow);
        margin-bottom: 1.5rem;
    }

    .profile-name {
        font-size: 2rem;
        color: var(--primary);
        margin-bottom: 0.5rem;
    }

    .profile-details {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 1rem;
        margin-top: 1.5rem;
    }

    .profile-item {
        background: var(--primary-light);
        padding: 1rem;
        border-radius: 10px;
        transition: var(--transition);
    }

    .profile-item:hover {
        transform: translateY(-3px);
        box-shadow: var(--shadow);
    }

    .profile-label {
        font-size: 0.9rem;
        color: var(--text-light);
        margin-bottom: 0.25rem;
        text-transform: uppercase;
    }

    .profile-value {
        font-weight: 600;
        color: var(--text);
    }

    .map-container {
        height: 300px;
        border-radius: 15px;
        overflow: hidden;
        box-shadow: var(--shadow);
        margin-top: 2rem;
    }

    #map {
        width: 100%;
        height: 100%;
    }

    .health-charts {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 1.5rem;
    }

    .health-chart-card {
        background: var(--white);
        border-radius: 15px;
        padding: 1.5rem;
        text-align: center;
        transition: var(--transition);
    }

    .health-chart-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 15px rgba(46, 204, 113, 0.2);
    }

    .health-chart-icon {
        font-size: 2.5rem;
        color: var(--primary);
        margin-bottom: 1rem;
    }

    .health-chart-title {
        font-size: 1.1rem;
        color: var(--text-light);
        margin-bottom: 0.5rem;
    }

    .health-chart-value {
        font-size: 2.5rem;
        font-weight: 700;
        color: var(--text);
        margin-bottom: 1rem;
    }

    .progress {
        height: 10px;
        background-color: var(--border);
        border-radius: 5px;
        overflow: hidden;
    }

    .progress-bar {
        height: 100%;
        background-color: var(--secondary);
        transition: width 0.5s ease-in-out;
    }

    .btn {
        display: block;
        padding: 15px 20px;
        border: none;
        border-radius: 10px;
        font-size: 1.2rem;
        font-weight: 600;
        cursor: pointer;
        transition: var(--transition);
        text-decoration: none;
        text-align: center;
        width: 100%;
        margin-top: 1rem;
        height: 58px;
    }

    .btn-primary {
        background-color: var(--primary);
        color: var(--white);
    }

    .btn-primary:hover {
        background-color: var(--secondary);
        transform: translateY(-2px);
    }

    .btn-secondary {
        background-color: var(--text-light);
        color: var(--white);
    }

    .btn-secondary:hover {
        background-color: var(--text);
        transform: translateY(-2px);
    }

    .tabs {
        display: flex;
        justify-content: center;
        margin-bottom: 1rem;
        background: #e0f7fa;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
    }

    .tab {
        flex: 1;
        text-align: center;
        padding: 1rem;
        font-weight: 600;
        color: #555;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    .tab.active {
        background: #2ECC71FF;
        color: white;
    }

    .tab-content {
        display: none;
    }

    .tab-content.active {
        display: block;
    }

    /* 새로 추가된 스타일 */
    .btn-video-call {
        background-color: #4CAF50;
        color: white;
        border: none;
        padding: 15px 30px;
        border-radius: 50px;
        font-size: 1.2rem;
        font-weight: 600;
        text-decoration: none;
        display: inline-block;
        transition: all 0.3s ease;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        margin-top: 20px;
        margin-bottom: 20px;
    }

    .btn-video-call:hover {
        background-color: #45a049;
        transform: translateY(-2px);
        box-shadow: 0 6px 8px rgba(0, 0, 0, 0.15);
    }

    #liveMap {
        border-radius: 15px;
        overflow: hidden;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        margin-top: 20px;
    }

    .worklog-list {
        background: white;
        border-radius: 15px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        overflow: hidden;
        margin-bottom: 20px;
    }

    .worklog-item {
        display: flex;
        align-items: center;
        padding: 20px;
        border-bottom: 1px solid #e0e0e0;
        transition: all 0.3s ease;
    }

    .worklog-item:last-child {
        border-bottom: none;
    }

    .worklog-item:hover {
        background-color: #f5f5f5;
    }

    .worklog-date {
        flex: 1;
        font-size: 1.1rem;
        color: #333;
    }

    .worklog-action {
        background-color: #4CAF50;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 25px;
        font-size: 0.9rem;
        text-decoration: none;
        transition: all 0.3s ease;
    }

    .worklog-action:hover {
        background-color: #45a049;
        transform: translateY(-2px);
    }

    @media (max-width: 1200px) {
        .dashboard {
            grid-template-columns: 1fr;
        }
    }

    @media (max-width: 768px) {
        .container {
            padding: 1rem;
        }

        .health-charts {
            grid-template-columns: 1fr;
        }

        .profile-details {
            grid-template-columns: 1fr;
        }
    }
</style>

<div class="container">
    <div class="dashboard">
        <div class="card">
            <div class="card-header">
                프로필 정보
            </div>
            <div class="card-body">
                <div class="profile-section">
                    <img src="/imgs/senior/${contractDetails.senior.seniorProfile}"
                         alt="${contractDetails.senior.seniorName} 어르신 프로필"
                         class="profile-image">
                    <h2 class="profile-name">${contractDetails.senior.seniorName} 어르신</h2>
                    <a href="/careworker/rtc?userId=${contractDetails.user.userId}"
                       class="btn-video-call">
                        <i class="fas fa-video"></i> 고객 화상통화 연결
                    </a>
                    <div class="profile-details">
                        <div class="profile-item">
                            <div class="profile-label">성별</div>
                            <div class="profile-value">
                                <c:choose>
                                    <c:when test="${contractDetails.senior.seniorGender == 'M'}">남자</c:when>
                                    <c:when test="${contractDetails.senior.seniorGender == 'F'}">여자</c:when>
                                    <c:otherwise>-</c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="profile-item">
                            <div class="profile-label">전화번호</div>
                            <div class="profile-value">${contractDetails.senior.seniorTel}</div>
                        </div>
                        <div class="profile-item">
                            <div class="profile-label">생년월일</div>
                            <div class="profile-value">${contractDetails.senior.seniorBirth}</div>
                        </div>
                        <div class="profile-item">
                            <div class="profile-label">주소</div>
                            <div class="profile-value">${contractDetails.senior.seniorStreetAddr}, ${contractDetails.senior.seniorDetailAddr1}, ${contractDetails.senior.seniorDetailAddr2}</div>
                        </div>
                    </div>
                </div>
                <div class="map-container">
                    <div id="map"
                         data-cw-lat="${contractDetails.careworker.cwLatitude}"
                         data-cw-lng="${contractDetails.careworker.cwLongitude}"
                         data-sr-lat="${contractDetails.senior.seniorLatitude}"
                         data-sr-lng="${contractDetails.senior.seniorLongitude}">
                    </div>
                </div>
            </div>
        </div>

        <div class="card">
            <div class="tabs">
                <div class="tab active" id="tab-live">실시간 모니터링</div>
                <div class="tab" id="tab-worklog">업무일지</div>
            </div>

            <div class="tab-content active" id="content-info">
                <div class="card-body">
                    <div class="health-charts">
                        <div class="health-chart-card">
                            <div class="health-chart-icon">💗</div>
                            <h3 class="health-chart-title">수축기 혈압</h3>
                            <div class="health-chart-value" id="systolicBP">--</div>
                            <div class="progress">
                                <div id="progress1" class="progress-bar" role="progressbar"
                                     style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100">
                                </div>
                            </div>
                        </div>
                        <div class="health-chart-card">
                            <div class="health-chart-icon">💓</div>
                            <h3 class="health-chart-title">확장기 혈압</h3>
                            <div class="health-chart-value" id="diastolicBP">--</div>
                            <div class="progress">
                                <div id="progress2" class="progress-bar" role="progressbar"
                                     style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                        </div>
                        <div class="health-chart-card">
                            <div class="health-chart-icon">❤️</div>
                            <h3 class="health-chart-title">심박수</h3>
                            <div class="health-chart-value" id="heartRate">--</div>
                            <div class="progress">
                                <div id="progress3" class="progress-bar" role="progressbar"
                                     style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                        </div>
                        <div class="health-chart-card">
                            <div class="health-chart-icon">🌡️</div>
                            <h3 class="health-chart-title">체온</h3>
                            <div class="health-chart-value" id="temperature">--</div>
                            <div class="progress">
                                <div id="progress4" class="progress-bar" role="progressbar"
                                     style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                        </div>
                    </div>
                    <div id="liveMap" style="width:100%;height:600px;"
                         data-sr-lat="${contractDetails.senior.seniorLatitude}"
                         data-sr-lng="${contractDetails.senior.seniorLongitude}"></div>
                </div>
            </div>
            <div class="tab-content" id="content-worklog">
                <div class="worklog-list">
                    <c:forEach var="worklog" items="${workLogs}">
                        <div class="worklog-item">
                            <div class="worklog-date">
                                <fmt:parseDate value="${worklog.workLogRdate}"
                                               pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime" type="both"/>
                                <fmt:formatDate pattern="yyyy년 MM월 dd일 HH시 mm분" value="${parsedDateTime}"/>
                            </div>
                            <a href="/careworker/worklog?workLogId=${worklog.workLogId}" class="worklog-action">
                                자세히 보기
                            </a>
                        </div>
                    </c:forEach>
                </div>
                <div class="card-body">
                    <a href="/careworker/worklog/saveform?seniorId=${contractDetails.senior.seniorId}"
                       class="btn btn-primary">업무일지 작성</a>
                    <a href="/careworker/seniors" class="btn btn-secondary">목록으로</a>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    const seniorId = '${contractDetails.senior.seniorId}';

    let index = {
        init: function () {
            this.setupTabs();
            this.fetchDataAndUpdateCharts();
            setInterval(this.fetchDataAndUpdateCharts, 2000);
            this.initKakaoMap();
            this.initLiveKakaoMap();
        },
        setupTabs: function () {
            $("#tab-live").click(function () {
                $(".tab").removeClass("active");
                $(this).addClass("active");
                $(".tab-content").removeClass("active");
                $("#content-info").addClass("active");
            });

            $("#tab-worklog").click(function () {
                $(".tab").removeClass("active");
                $(this).addClass("active");
                $(".tab-content").removeClass("active");
                $("#content-worklog").addClass("active");
            });
        },
        fetchDataAndUpdateCharts: function () {
            const url = '/iot/health/data/' + seniorId;

            $.ajax({
                url: url,
                method: 'GET',
                dataType: 'json',
                success: function (response) {
                    if (!response || response.length === 0) {
                        console.warn("No data available for seniorId:", seniorId);
                        return;
                    }

                    const latestData = response[response.length - 1];
                    if (latestData) {
                        let p1 = latestData.systolicBP;
                        let p2 = latestData.diastolicBP;
                        let p3 = latestData.heartRate;
                        let p4 = latestData.temperature;
                        document.getElementById("systolicBP").innerText = p1;
                        document.getElementById("diastolicBP").innerText = p2;
                        document.getElementById("heartRate").innerText = p3;
                        document.getElementById("temperature").innerText = p4;

                        $('#progress1').css('width', JSON.parse(p1) / 200 * 100 + '%');
                        $('#progress1').attr('aria-valuenow', JSON.parse(p1) / 200 * 100);
                        $('#progress2').css('width', JSON.parse(p2) / 120 * 100 + '%');
                        $('#progress2').attr('aria-valuenow', JSON.parse(p2) / 120 * 100);
                        $('#progress3').css('width', JSON.parse(p3) / 120 * 100 + '%');
                        $('#progress3').attr('aria-valuenow', JSON.parse(p3) / 120 * 100);
                        $('#progress4').css('width', JSON.parse(p4) / 45 * 100 + '%');
                        $('#progress4').attr('aria-valuenow', JSON.parse(p4) / 45 * 100);
                    }
                },
                error: function (xhr, status, error) {
                    console.error(`Error fetching data: Status ${xhr.status}, Error: ${error}`);
                }
            });
        },
        initKakaoMap: function () {
            const careworkerLat = parseFloat($("#map").data("cw-lat"));
            const careworkerLng = parseFloat($("#map").data("cw-lng"));
            const seniorLat = parseFloat($("#map").data("sr-lat"));
            const seniorLng = parseFloat($("#map").data("sr-lng"));

            kakao.maps.load(() => {
                const mapContainer = document.getElementById('map');
                const centerPosition = new kakao.maps.LatLng(careworkerLat, careworkerLng);

                const mapOption = {
                    center: centerPosition,
                    level: 5
                };

                const map = new kakao.maps.Map(mapContainer, mapOption);

                const careworkerMarkerImage = new kakao.maps.MarkerImage(
                    "../../images/caregiver.png",
                    new kakao.maps.Size(32, 32)
                );

                const careworkerMarker = new kakao.maps.Marker({
                    position: centerPosition,
                    map: map,
                    image: careworkerMarkerImage
                });

                const careworkerOverlayContent = `
                <div style="
                    background: #ffffff;
                    border: 2px solid #ffffff;
                    border-radius: 10px;
                    padding: 3px;
                    font-size: 12px;
                    text-align: center;
                    box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
                    <strong style="color: black;">내 위치</strong>
                </div>
            `;

                const careworkerOverlay = new kakao.maps.CustomOverlay({
                    position: centerPosition,
                    content: careworkerOverlayContent,
                    yAnchor: 2.2
                });

                careworkerOverlay.setMap(map);

                const seniorMarkerImage = new kakao.maps.MarkerImage(
                    "../../images/seniormap.png",
                    new kakao.maps.Size(32, 32)
                );

                const seniorMarker = new kakao.maps.Marker({
                    position: new kakao.maps.LatLng(seniorLat, seniorLng),
                    map: map,
                    image: seniorMarkerImage
                });

                const seniorOverlayContent = `
                <div style="
                    background: #ffffff;
                    border: 2px solid #ffffff;
                    border-radius: 10px;
                    padding: 3px;
                    font-size: 12px;
                    text-align: center;
                    box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
                    <strong style="color: black;">시니어 위치</strong>
                </div>
            `;

                const seniorOverlay = new kakao.maps.CustomOverlay({
                    position: new kakao.maps.LatLng(seniorLat, seniorLng),
                    content: seniorOverlayContent,
                    yAnchor: 2.2
                });

                seniorOverlay.setMap(map);

                const linePath = [
                    new kakao.maps.LatLng(careworkerLat, careworkerLng),
                    new kakao.maps.LatLng(seniorLat, seniorLng)
                ];

                const polyline = new kakao.maps.Polyline({
                    path: linePath,
                    strokeWeight: 5,
                    strokeColor: '#4CAF50',
                    strokeOpacity: 0.8,
                    strokeStyle: 'dashed'
                });

                polyline.setMap(map);
            });
        },
        initLiveKakaoMap: function () {
            const lat = parseFloat($("#liveMap").data("sr-lat"));
            const lng = parseFloat($("#liveMap").data("sr-lng"));

            var mapContainer = document.getElementById('liveMap');
            var mapOption = {
                center: new kakao.maps.LatLng(lat, lng),
                level: 2
            };

            var map = new kakao.maps.Map(mapContainer, mapOption);

            var seniorMovingMarker = null;
            const MIN_STEP_SIZE = 1.5;
            const MAX_STEP_SIZE = 5;

            setInterval(updateSeniorMovingMarker, 1000);

            function getWalkingPosition(currentLat, currentLng) {
                const randomStepSize = Math.random() * (MAX_STEP_SIZE - MIN_STEP_SIZE) + MIN_STEP_SIZE;
                const randomAngle = Math.random() * Math.PI * 2;
                const deltaLat = randomStepSize * Math.cos(randomAngle) / 111000;
                const deltaLng = randomStepSize * Math.sin(randomAngle) / (111000 * Math.cos(currentLat * Math.PI / 180));
                return {
                    lat: currentLat + deltaLat,
                    lng: currentLng + deltaLng
                };
            }

            function updateSeniorMovingMarker() {
                const randomPosition = getWalkingPosition(lat, lng);
                console.log("New Position:", randomPosition);
                if (!seniorMovingMarker) {
                    var content = `
                <div class="custom-overlay">
                    <img src="../../images/move.png" style="width:30px; height:30px;" />
                </div>
            `;

                    seniorMovingMarker = new kakao.maps.CustomOverlay({
                        position: new kakao.maps.LatLng(randomPosition.lat, randomPosition.lng),
                        content: content,
                        map: map
                    });
                } else {
                    const newLatLng = new kakao.maps.LatLng(randomPosition.lat, randomPosition.lng);
                    seniorMovingMarker.setPosition(newLatLng);
                }

                this.lat = randomPosition.lat;
                this.lng = randomPosition.lng;
            }
        },
    }
    index.init();
</script>