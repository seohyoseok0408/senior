<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container mt-4">
    <!-- 탭 -->
    <ul class="nav nav-tabs">
        <li class="nav-item">
            <a class="nav-link <c:if test='${param.status == null || param.status == ""}'>active</c:if>'"
               href="/careworker/contracts">전체 보기</a>
        </li>
        <li class="nav-item">
            <a class="nav-link <c:if test='${param.status == "PENDING"}'>active</c:if>'"
               href="/careworker/contracts?status=PENDING">대기중</a>
        </li>
        <li class="nav-item">
            <a class="nav-link <c:if test='${param.status == "ACTIVE"}'>active</c:if>'"
               href="/careworker/contracts?status=ACTIVE">승인됨</a>
        </li>
    </ul>

    <!-- 리스트 -->
    <div class="row row-cols-1 row-cols-md-3 g-4 mt-3">
        <c:forEach var="details" items="${contractsWithDetails}">
            <div class="col">
                <div class="card h-100 shadow-lg border-0 rounded-lg">
                    <div class="card-header bg-primary text-white text-center py-3">
                        <h5 class="fw-bold mb-0">${details.user.userName} 고객님</h5>
                    </div>
                    <div class="card-body">
                        <p><strong>성함:</strong> ${details.senior.seniorName}</p>
                        <p><strong>생년월일:</strong> ${details.senior.seniorBirth}</p>
                        <p><strong>주소:</strong> ${details.senior.seniorStreetAddr}</p>
                        <p><strong>거리:</strong> ${details.distance} 떨어져 있음</p>
                        <p>
                            <strong>상태:</strong>
                            <span class="badge
                                <c:choose>
                                    <c:when test="${details.contract.contractStatus == 'PENDING'}">bg-warning text-dark</c:when>
                                    <c:when test="${details.contract.contractStatus == 'APPROVED'}">bg-success</c:when>
                                    <c:otherwise>bg-danger</c:otherwise>
                                </c:choose>">
                                    ${details.contract.contractStatus}
                            </span>
                        </p>
                    </div>
                    <div class="card-footer text-center">
                        <a href="/careworker/contract?contractId=${details.contract.contractId}" class="btn btn-primary btn-sm">자세히 보기</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
