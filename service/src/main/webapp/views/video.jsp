<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container">
    <!-- 헤더 -->
    <div class="header">
        <h1>시니어 케어</h1>
        <p>실시간 화상 통화를 시작하세요</p>
    </div>

    <!-- 룸 컨트롤 -->
    <div class="room-controls">
        <div class="input-group">
            <input type="hidden" id="roomId" value="${contractId}">
            <button class="btn btn-success" id="startSteamBtn">
                <i class="fas fa-video"></i> 스트리밍 시작
            </button>
        </div>

    </div>

    <!-- 스트림 영역 -->
    <div class="streams-container">
        <!-- 로컬 스트림 -->
        <div class="stream-card">
            <div class="stream-header">
                <i class="fas fa-user"></i>
                <c:choose>
                    <c:when test="${sessionScope.role == 'USER'}">
                    고객</c:when>
                <c:when test="${sessionScope.role == 'CAREWORKER'}">
                    보호사</c:when>
                </c:choose>
            </div>
            <div class="stream-body">
                <div class="video-container">
                    <video id="localStream" autoplay playsinline controls class="d-none"></video>
                </div>
            </div>
        </div>

        <!-- 원격 스트림 -->
        <div class="stream-card">
            <div class="stream-header">
                <i class="fas fa-users"></i>
                <c:choose>
                    <c:when test="${sessionScope.role == 'USER'}">
                        보호사</c:when>
                    <c:when test="${sessionScope.role == 'CAREWORKER'}">
                        고객</c:when>
                </c:choose>
            </div>
            <div class="stream-body">
                <div id="remoteStreamDiv">
                    <!-- 상대 스트림이 동적으로 추가됩니다 -->
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 스크립트 -->
<script src="/js/rtc.js"></script>
