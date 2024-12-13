<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap');

    body, html {
        margin: 0;
        padding: 0;
        font-family: 'Noto Sans KR', sans-serif;
        background-color: #f8f9fa;
    }

    .map_wrap {
        position: relative;
        width: 100%;
        height: 100vh;
        overflow: hidden;
    }

    #senior_address_wrap {
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 70px;
        background-color: #f8f9fa;
        display: flex;
        align-items: center;
        padding: 0 20px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        z-index: 3;
    }

    #seniorAddressDisplay {
        font-size: 18px;
        font-weight: 500;
        color: #333;
        margin-left: 10px;
    }

    #seniorDetailAddressDisplay {
        font-size: 16px;
        color: #666;
        margin-left: 5px;
    }

    #map {
        width: 100%;
        height: calc(100% - 70px);
        position: absolute;
        top: 70px;
        left: 0;
    }

    #category_wrap {
        position: absolute;
        top: 80px;
        left: 10px;
        z-index: 2;
        background-color: #ffffff;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        overflow: hidden;
    }

    #category_wrap button {
        padding: 12px 20px;
        border: none;
        background-color: #ffffff;
        cursor: pointer;
        font-size: 14px;
        font-weight: 500;
        color: #333;
        transition: all 0.3s ease;
    }

    #category_wrap button:hover {
        background-color: #f0f0f0;
    }

    #category_wrap button.active {
        background-color: #45C65A;
        color: white;
    }

    #menu_wrap {
        position: absolute;
        top: 140px;
        left: 10px;
        width: 350px;
        max-height: calc(100% - 160px);
        overflow-y: auto;
        background: #ffffff;
        z-index: 1;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }

    #placesList {
        padding: 0;
        margin: 0;
    }

    #placesList li {
        list-style: none;
        padding: 15px;
        border-bottom: 1px solid #eee;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    #placesList li:hover {
        background-color: #f9f9f9;
    }

    #placesList .item h5 {
        font-size: 16px;
        font-weight: 500;
        margin: 0 0 5px 0;
        color: #333;
    }

    #placesList .item .info {
        font-size: 14px;
        color: #666;
    }

    #placesList .info .tel {
        color: #45C65A;
        font-weight: 500;
        margin-top: 5px;
    }

    #pagination {
        margin-top: 10px;
        text-align: center;
    }

    #pagination a {
        display: inline-block;
        margin: 0 5px;
        padding: 5px 10px;
        border-radius: 3px;
        background-color: #f0f0f0;
        color: #333;
        text-decoration: none;
        transition: all 0.3s ease;
    }

    #pagination a.on {
        background-color: #45C65A;
        color: white;
    }

    .material-icons {
        vertical-align: middle;
    }
</style>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

<div class="map_wrap">
    <div id="senior_address_wrap">
        <span class="material-icons" style="font-size: 28px; color:#45C65A;">place</span>
        <span id="seniorAddressDisplay">${senior.seniorStreetAddr}</span>
        <span id="seniorDetailAddressDisplay">${senior.seniorDetailAddr2}</span>
    </div>

    <div id="map"></div>

    <div id="category_wrap">
        <button id="hospitalBtn" onclick="updateCategory('HP8')" class="active">병원</button>
        <button id="pharmacyBtn" onclick="updateCategory('PM9')">약국</button>
    </div>

    <div id="menu_wrap">
        <ul id="placesList"></ul>
        <div id="pagination"></div>
    </div>

    <input type="hidden" value="${senior.seniorLatitude}" id="seniorLat">
    <input type="hidden" value="${senior.seniorLongitude}" id="seniorLng">
    <input type="hidden" id="seniorProfile" value="/images/default-profile.jpg">
</div>

<script src="/js/map.js"></script>

