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
    height: 500px;
  }

</style>

<div class="map_wrap">
  <!-- 지도 영역 -->
  <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>

  <!-- 시니어 좌표 -->
  <input type="hidden" value="${senior.seniorLatitude}" id="seniorLat">
  <input type="hidden" value="${senior.seniorLongitude}" id="seniorLng">
  <input type="hidden" id="seniorProfile" value="/images/default-profile.jpg">
</div>

<!-- Kakao 지도 API -->
<script type="text/javascript"
        src="//dapi.kakao.com/v2/maps/sdk.js?appkey=24292fb5ce2d2498c2ed88d0a951d790&libraries=services"></script>
<script src="/js/seniormove.js"></script>
