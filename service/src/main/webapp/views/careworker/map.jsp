<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    .map-container {
        position: relative;
        width: 100%;
        height: 60vh; /* 기본 높이: 화면 높이의 60% */
    }

    @media (max-width: 768px) {
        .map-container {
            height: 50vh; /* 태블릿 및 모바일: 화면 높이의 50% */
        }
    }

    @media (max-width: 480px) {
        .map-container {
            height: 40vh; /* 작은 모바일 화면: 화면 높이의 40% */
        }
    }

    #map {
        width: 100%;
        height: 100%;
        position: relative;
        overflow: hidden;
    }
</style>
<div>
    <h1>관리 중인 시니어들의 위치</h1>
</div>
<div class="map-container">
    <div id="map"></div>
</div>

<input type="hidden" id="centerLat" value="${careworker.cwLatitude}">
<input type="hidden" id="centerLng" value="${careworker.cwLongitude}">
<c:forEach var="details" items="${contractsWithDetails}">
    <input type="hidden" class="senior" data-lat="${details.senior.seniorLatitude}"
           data-lng="${details.senior.seniorLongitude}" data-name="${details.senior.seniorName}" data-profile="${details.senior.seniorProfile}" data-code="${details.senior.seniorId}">
</c:forEach>

<!-- Kakao 지도 API -->
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=YOUR_API_KEY&libraries=services"></script>
<script src="/js/careMap.js"></script>
