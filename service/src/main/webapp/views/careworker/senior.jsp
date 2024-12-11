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

    .contracts-list {
        background: white;
        border-radius: 15px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .contract-item {
        display: flex;
        align-items: center;
        padding: 1.5rem;
        border-bottom: 1px solid #e9ecef;
        transition: all 0.3s ease;
    }

    .contract-item:last-child {
        border-bottom: none;
    }

    .contract-item:hover {
        background-color: #f8f9fa;
    }

    .contract-main {
        flex: 1;
        display: grid;
        align-items: center;
    }
    .customer-info {
        display: flex;
        flex-direction: column;
    }

    .title-name {
        font-size: 1.1rem;
        font-weight: 600;
        color: #40c057;
        margin-bottom: 0.25rem;
    }

    .action-btn {
        background-color: #40c057;
        color: white;
        border: none;
        border-radius: 25px;
        padding: 0.5rem 1.5rem;
        font-weight: 500;
        text-decoration: none;
        transition: all 0.2s ease;
    }

    .action-btn:hover {
        background-color: #2b8a3e;
        transform: translateY(-2px);
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
                       class="btn btn-primary">고객 화상통화 연결</a>
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
                    <div id="liveMap" style="width:100%;height:500px;"
                         data-sr-lat="${contractDetails.senior.seniorLatitude}"
                         data-sr-lng="${contractDetails.senior.seniorLongitude}"></div>
                </div>
            </div>
            <div class="tab-content" id="content-worklog">
                <div class="contracts-list">
                    <c:forEach var="worklog" items="${workLogs}">
                        <div class="contract-item">
                            <div class="contract-main">
                                <div class="customer-info">
                                <span class="title-name">
                                    <fmt:parseDate value="${worklog.workLogRdate}"
                                                   pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime" type="both" />
                                    <fmt:formatDate pattern="yyyy년 MM월 dd일 HH시 mm분" value="${ parsedDateTime }" />
                                </span>
                                </div>
                                <div class="status-info">

                                </div>
                            </div>
                            <a href="/careworker/worklog?workLogId=${worklog.workLogId}" class="action-btn">
                                자세히 보기
                            </a>
                        </div>
                    </c:forEach>
                </div>
                <div>
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
            // 탭 클릭 이벤트 설정
            this.setupTabs();

            // 주기적으로 데이터를 가져오고 업데이트
            this.fetchDataAndUpdateCharts(); // 초기 호출
            setInterval(this.fetchDataAndUpdateCharts, 2000);

            // 지도 초기화
            this.initKakaoMap();
            this.initLiveKakaoMap();
        },
        setupTabs: function () {
            // 탭 버튼 클릭 이벤트 등록
            $("#tab-live").click(function () {
                $(".tab").removeClass("active"); // 모든 탭에서 'active' 제거
                $(this).addClass("active"); // 현재 클릭된 탭에 'active' 추가
                $(".tab-content").removeClass("active"); // 모든 탭 콘텐츠 숨김
                $("#content-info").addClass("active"); // 선택된 탭 콘텐츠 표시
            });

            $("#tab-worklog").click(function () {
                $(".tab").removeClass("active"); // 모든 탭에서 'active' 제거
                $(this).addClass("active"); // 현재 클릭된 탭에 'active' 추가
                $(".tab-content").removeClass("active"); // 모든 탭 콘텐츠 숨김
                $("#content-worklog").addClass("active"); // 선택된 탭 콘텐츠 표시
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

                    // 최신 로그 데이터를 기반으로 업데이트
                    const latestData = response[response.length - 1];
                    if (latestData) {
                        // 텍스트 직접 업데이트 (직접 ID로 접근)
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
        updateCard: function (elementId, value, progressBarId, min, max) {
            const element = document.getElementById(elementId);
            const progressBar = document.getElementById(progressBarId);

            // 텍스트 업데이트
            if (element) {
                element.innerText = value;
            }

            // Progress Bar 업데이트
            if (progressBar) {
                const percentage = Math.max(0, Math.min(100, ((value - min) / (max - min)) * 100));
                progressBar.style.width = `${percentage}%`; // Progress Bar 너비 조정
                progressBar.setAttribute("aria-valuenow", percentage); // 접근성 속성 업데이트
            }
        },
        initKakaoMap: function () {
            const careworkerLat = parseFloat($("#map").data("cw-lat"));
            const careworkerLng = parseFloat($("#map").data("cw-lng"));
            const seniorLat = parseFloat($("#map").data("sr-lat"));
            const seniorLng = parseFloat($("#map").data("sr-lng"));

            kakao.maps.load(() => {
                const mapContainer = document.getElementById('map'); // 지도 컨테이너
                const centerPosition = new kakao.maps.LatLng(careworkerLat, careworkerLng);

                const mapOption = {
                    center: centerPosition,
                    level: 5 // 확대 레벨
                };

                const map = new kakao.maps.Map(mapContainer, mapOption);

                // 보호사 마커 및 커스텀 오버레이 설정
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
                    yAnchor: 2.2 // 마커 바로 위에 위치
                });

                careworkerOverlay.setMap(map);

                // 시니어 마커 및 커스텀 오버레이 설정
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
                    yAnchor: 2.2 // 마커 바로 위에 위치
                });

                seniorOverlay.setMap(map);

                // 선(Polyline) 그리기
                const linePath = [
                    new kakao.maps.LatLng(careworkerLat, careworkerLng),
                    new kakao.maps.LatLng(seniorLat, seniorLng)
                ];

                const polyline = new kakao.maps.Polyline({
                    path: linePath,
                    strokeWeight: 5,
                    strokeColor: '#FFAE00',
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

            var seniorMovingMarker = null; // 단일 마커 객체로 선언
            const MIN_STEP_SIZE = 1.5; // 최소 이동 거리 (1.5m)
            const MAX_STEP_SIZE = 5;  // 최대 이동 거리 (10m)

            setInterval(updateSeniorMovingMarker, 1000); // 1초 간격

            function getWalkingPosition(currentLat, currentLng) {
                const randomStepSize = Math.random() * (MAX_STEP_SIZE - MIN_STEP_SIZE) + MIN_STEP_SIZE; // 랜덤 이동 거리
                const randomAngle = Math.random() * Math.PI * 2; // 랜덤 방향 (0 ~ 360도)
                const deltaLat = randomStepSize * Math.cos(randomAngle) / 111000; // 위도 변위 계산
                const deltaLng = randomStepSize * Math.sin(randomAngle) / (111000 * Math.cos(currentLat * Math.PI / 180)); // 경도 변위 계산
                return {
                    lat: currentLat + deltaLat,
                    lng: currentLng + deltaLng
                };
            }

            // 이동 마커 생성 및 위치 업데이트 함수
            function updateSeniorMovingMarker() {
                // 새로운 위치 계산
                const randomPosition = getWalkingPosition(lat, lng);
                console.log("New Position:", randomPosition);
                if (!seniorMovingMarker) {
                    // 초기 이동 마커 생성
                    var content = `
            <div class="custom-overlay">
                <img src="../../images/seniormove.png" style="width:50px; height:50px; border-radius:50%;" />
            </div>
        `;

                    seniorMovingMarker = new kakao.maps.CustomOverlay({
                        position: new kakao.maps.LatLng(randomPosition.lat, randomPosition.lng),
                        content: content,
                        map: map
                    });
                } else {
                    // 기존 마커 위치 업데이트
                    const newLatLng = new kakao.maps.LatLng(randomPosition.lat, randomPosition.lng);
                    seniorMovingMarker.setPosition(newLatLng);
                }

                // 현재 위치를 기준으로 다음 이동 기준 좌표 업데이트
                this.lat = randomPosition.lat;
                this.lng = randomPosition.lng;
            }
        },
    }
    index.init();
</script>

