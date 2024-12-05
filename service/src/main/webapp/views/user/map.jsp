<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    .map_wrap, .map_wrap * {
        margin: 0;
        padding: 0;
        font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
        font-size: 12px;
    }

    .map_wrap {
        position: relative;
        width: 100%;
        height: 800px;
    }

    #senior_address_wrap {
        position: relative;
        width: 100%;
        height: 70px; /* 상단 영역 높이 설정 */
        background-color: rgba(255, 255, 255, 0.9);
        display: flex;
        align-items: center;
        justify-content: flex-start;
        color: #333;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        z-index: 3;
    }

    #seniorAddressDisplay {
        font-size: 24px;
        font-weight: bold;
    }

    #seniorDetailAddressDisplay {
        font-size: 24px;
        font-weight: bold;
    }

    #map {
        width: 100%;
        height: calc(100% - 70px); /* 상단 영역 제외한 높이 */
        position: relative;
        overflow: hidden;
        margin-top: 0;
    }

    #category_wrap {
        position: absolute;
        top: 70px; /* 지도 상단에서 카테고리 버튼 위치 */
        left: 10px;
        z-index: 2;
    }

    #category_wrap button {
        margin: 5px;
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        background-color: #f5f5f5;
        cursor: pointer;
        font-size: 14px;
    }

    #category_wrap button.active {
        background-color: #81c147;
        color: white;
        font-weight: bold;
    }

    #menu_wrap {
        position: absolute;
        top: 110px;
        left: 10px;
        width: 250px;
        height: calc(100% - 120px);
        overflow-y: auto;
        background: rgba(255, 255, 255, 0.8);
        z-index: 1;
        font-size: 12px;
        border-radius: 10px;
        padding: 10px;
    }

    #placesList li {
        list-style: none;
    }

    #placesList .item {
        position: relative;
        border-bottom: 1px solid #888;
        overflow: hidden;
        cursor: pointer;
        min-height: 65px;
    }

    #placesList .item span {
        display: block;
        margin-top: 4px;
    }

    #placesList .item h5, #placesList .item .info {
        text-overflow: ellipsis;
        overflow: hidden;
        white-space: nowrap;
    }

    #placesList .item .info {
        padding: 10px 0 10px 55px;
    }

    #placesList .info .gray {
        color: #8a8a8a;
    }

    #placesList .info .jibun {
        padding-left: 26px;
        background: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;
    }

    #placesList .info .tel {
        color: #009900;
    }

    #placesList .item .markerbg {
        float: left;
        position: absolute;
        width: 36px;
        height: 37px;
        margin: 10px 0 0 10px;
        background: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;
    }

    #placesList .item .marker_1 {
        background-position: 0 -10px;
    }

    #placesList .item .marker_2 {
        background-position: 0 -56px;
    }

    #placesList .item .marker_3 {
        background-position: 0 -102px
    }

    #placesList .item .marker_4 {
        background-position: 0 -148px;
    }

    #placesList .item .marker_5 {
        background-position: 0 -194px;
    }

    #placesList .item .marker_6 {
        background-position: 0 -240px;
    }

    #placesList .item .marker_7 {
        background-position: 0 -286px;
    }

    #placesList .item .marker_8 {
        background-position: 0 -332px;
    }

    #placesList .item .marker_9 {
        background-position: 0 -378px;
    }

    #placesList .item .marker_10 {
        background-position: 0 -423px;
    }

    #placesList .item .marker_11 {
        background-position: 0 -470px;
    }

    #placesList .item .marker_12 {
        background-position: 0 -516px;
    }

    #placesList .item .marker_13 {
        background-position: 0 -562px;
    }

    #placesList .item .marker_14 {
        background-position: 0 -608px;
    }

    #placesList .item .marker_15 {
        background-position: 0 -654px;
    }
</style>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

<div class="map_wrap">

    <div id="senior_address_wrap">
        <span class="material-icons" style="font-size: 34px; margin-left:0; color:#45C65A;">place</span>
        <span id="seniorAddressDisplay">${senior.seniorStreetAddr}</span>
        <span id="seniorDetailAddressDisplay">, ${senior.seniorDetailAddr2}</span>
    </div>

    <!-- 지도 영역 -->
    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>

    <!-- 카테고리 버튼 -->
    <div id="category_wrap">
        <button id="hospitalBtn" onclick="updateCategory('HP8')" class="active">병원</button>
        <button id="pharmacyBtn" onclick="updateCategory('PM9')">약국</button>
    </div>

    <!-- 장소 정보 -->
    <div id="menu_wrap" class="bg_white">
        <ul id="placesList"></ul>
    </div>

    <!-- 시니어 좌표 -->
    <input type="hidden" value="${senior.seniorLatitude}" id="seniorLat">
    <input type="hidden" value="${senior.seniorLongitude}" id="seniorLng">
    <input type="hidden" id="seniorProfile" value="/images/default-profile.jpg">

</div>

<!-- Kakao 지도 API -->
<script type="text/javascript"
        src="//dapi.kakao.com/v2/maps/sdk.js?appkey=24292fb5ce2d2498c2ed88d0a951d790&libraries=services"></script>
<script src="/js/map.js"></script>
