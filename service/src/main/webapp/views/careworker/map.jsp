<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap');

    :root {
        --primary: #2ecc71;
        --secondary: #27ae60;
        --accent: #f39c12;
        --background: #ecf0f1;
        --text: #2c3e50;
        --light: #FFFFFF;
        --shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: var(--background);
        color: var(--text);
        line-height: 1.6;
    }

    .care-hub {
        max-width: 1200px;
        margin: 2rem auto;
        padding: 2rem;
        background-color: var(--light);
        border-radius: 20px;
        box-shadow: var(--shadow);
    }

    .care-hub-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 2rem;
        padding-bottom: 1rem;
        border-bottom: 2px solid var(--secondary);
    }

    .care-hub-title {
        font-size: 2.5rem;
        font-weight: 700;
        color: var(--secondary);
        position: relative;
    }


    .care-hub-stats {
        display: flex;
        gap: 1rem;
    }

    .stat-card {
        background-color: var(--light);
        color: var(--text);
        padding: 1rem;
        border-radius: 10px;
        text-align: center;
        box-shadow: var(--shadow);
        transition: transform 0.3s ease, background-color 0.3s ease;
        border: 1px solid var(--secondary);
    }

    .stat-card:hover {
        transform: translateY(-5px);
        background-color: var(--secondary);
        color: var(--light);
    }

    .stat-value {
        font-size: 1.5rem;
        font-weight: 700;
        color: var(--primary);
    }

    .stat-card:hover .stat-value {
        color: var(--light);
    }

    .stat-label {
        font-size: 0.9rem;
        color: var(--text);
        opacity: 0.8;
    }

    .stat-card:hover .stat-label {
        color: var(--light);
        opacity: 1;
    }

    .map-container {
        position: relative;
        width: 100%;
        height: 70vh;
        border-radius: 20px;
        overflow: hidden;
        box-shadow: var(--shadow);
    }

    #map {
        width: 100%;
        height: 100%;
    }

    .map-controls {
        position: absolute;
        top: 1rem;
        right: 1rem;
        display: flex;
        gap: 0.5rem;
    }

    .map-control-btn {
        background-color: var(--secondary);
        color: var(--light);
        border: none;
        padding: 0.5rem 1rem;
        border-radius: 5px;
        cursor: pointer;
        transition: all 0.3s ease;
        font-weight: 500;
    }

    .map-control-btn:hover {
        background-color: var(--primary);
        color: var(--light);
    }

    @media (max-width: 768px) {
        .care-hub {
            padding: 1rem;
        }

        .care-hub-header {
            flex-direction: column;
            align-items: flex-start;
        }

        .care-hub-stats {
            margin-top: 1rem;
        }

        .map-container {
            height: 60vh;
        }
    }
</style>


<div class="care-hub">
    <div class="care-hub-header">
        <h1 class="care-hub-title">시니어케어 모니터링 센터</h1>
        <div class="care-hub-stats">
            <div class="stat-card">
                <div class="stat-value">${contractsWithDetails.size()}</div>
                <div class="stat-label">관리 중인 시니어</div>
            </div>
            <div class="stat-card">
                <div class="stat-value" id="averageDistance">계산 중...</div>
                <div class="stat-label">평균 거리 (km)</div>
            </div>
        </div>
    </div>
    <div class="map-container">
        <div id="map"></div>
        <div class="map-controls">
        </div>
    </div>
</div>

<input type="hidden" id="centerLat" value="${careworker.cwLatitude}">
<input type="hidden" id="centerLng" value="${careworker.cwLongitude}">
<c:forEach var="details" items="${contractsWithDetails}">
    <input type="hidden" class="senior" data-lat="${details.senior.seniorLatitude}"
           data-lng="${details.senior.seniorLongitude}" data-name="${details.senior.seniorName}"
           data-profile="${details.senior.seniorProfile}" data-code="${details.senior.seniorId}">
</c:forEach>

<!-- Kakao 지도 API -->
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=YOUR_API_KEY&libraries=services,clusterer,drawing"></script>
<script src="/js/careMap.js"></script>

<script>
    // 평균 거리 계산 함수
    function calculateAverageDistance() {
        const centerLat = parseFloat(document.getElementById('centerLat').value);
        const centerLng = parseFloat(document.getElementById('centerLng').value);
        const seniors = document.querySelectorAll('.senior');
        let totalDistance = 0;

        seniors.forEach(senior => {
            const seniorLat = parseFloat(senior.dataset.lat);
            const seniorLng = parseFloat(senior.dataset.lng);
            const distance = getDistanceFromLatLonInKm(centerLat, centerLng, seniorLat, seniorLng);
            totalDistance += distance;
        });

        const averageDistance = totalDistance / seniors.length;
        document.getElementById('averageDistance').textContent = averageDistance.toFixed(2);
    }

    // 두 지점 간의 거리 계산 함수 (Haversine 공식)
    function getDistanceFromLatLonInKm(lat1, lon1, lat2, lon2) {
        const R = 6371; // 지구의 반경 (km)
        const dLat = deg2rad(lat2 - lat1);
        const dLon = deg2rad(lon2 - lon1);
        const a =
            Math.sin(dLat / 2) * Math.sin(dLat / 2) +
            Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) *
            Math.sin(dLon / 2) * Math.sin(dLon / 2);
        const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        const distance = R * c;
        return distance;
    }

    function deg2rad(deg) {
        return deg * (Math.PI / 180)
    }

    // 페이지 로드 시 평균 거리 계산
    window.addEventListener('load', calculateAverageDistance);
</script>


