<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container mt-5">
    <h2 class="text-center mb-4">보호사 상세 정보</h2>

    <div class="card mb-4">
        <div class="row no-gutters">
            <!-- 보호사 프로필 사진 -->
            <div class="col-md-4">
                <c:choose>
                    <c:when test="${not empty careworker.cwProfile}">
                        <img src="/imgs/careworker/${careworker.cwProfile}" class="card-img" alt="${careworker.cwName}">
                    </c:when>
                    <c:otherwise>
                        <img src="/static/images/default-profile.png" class="card-img" alt="Default Profile">
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- 보호사 상세 정보 -->
            <div class="col-md-8">
                <div class="card-body">
                    <h5 class="card-title">${careworker.cwName} (${careworker.cwGender})</h5>
                    <p class="card-text">
                        <strong>연락처:</strong> ${careworker.cwTel}<br>
                        <strong>이메일:</strong> ${careworker.cwEmail}<br>
                        <strong>경력:</strong> ${careworker.cwExperience}년<br>
                        <strong>소개:</strong> ${careworker.cwIntro}<br>
                        <strong>휴일:</strong> ${careworker.cwHoliday}<br>
                    </p>
                </div>
            </div>
        </div>
    </div>

    <!-- 버튼 영역 -->
    <div class="text-center">
        <input type="hidden" id="careworkerId" value="${careworker.cwId}">
        <input type="hidden" id="seniorId" value="${seniorId}"/>
        <button type="button" id="contract-btn" class="btn btn-primary">계약 신청</button>
        <a href="/user/careworkers" class="btn btn-secondary">목록으로</a>
    </div>
</div>

<script src="/js/careworker.js"></script>