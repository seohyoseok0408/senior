<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container">
    <h2 style="text-align: center; margin-bottom: 2rem; color: var(--text); font-size: 2rem;">근처 보호사 찾기</h2>

    <div class="search-panel">
        <div class="form-group">
            <label for="senior-select" class="form-label">내 시니어 선택</label>
            <select id="senior-select" class="form-control">
                <c:forEach var="senior" items="${seniors}">
                    <option value="${senior.seniorId},${senior.seniorLatitude},${senior.seniorLongitude}">
                            ${senior.seniorName} (${senior.seniorStatus})
                    </option>
                </c:forEach>
            </select>
        </div>

        <div class="form-group">
            <label for="radius-select" class="form-label">검색 반경</label>
            <select id="radius-select" class="form-control">
                <option value="1">1 km</option>
                <option value="3">3 km</option>
                <option value="5" selected>5 km</option>
                <option value="10">10 km</option>
                <option value="20">20 km</option>
            </select>
        </div>

        <button id="search-btn" class="btn-primary">
            보호사 검색
        </button>
    </div>

    <div id="careworker-list"></div>
</div>

<script src="/js/careworker.js"></script>