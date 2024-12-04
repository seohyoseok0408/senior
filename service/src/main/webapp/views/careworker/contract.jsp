<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 2rem;
    }
    .nav-tabs {
        border-bottom: none;
        margin-bottom: 2rem;
    }
    .nav-tabs .nav-link {
        border: none;
        border-radius: 30px;
        padding: 0.75rem 1.5rem;
        font-weight: 600;
        color: #6c757d;
        transition: all 0.3s ease;
    }
    .nav-tabs .nav-link:hover {
        color: #495057;
        background-color: #e9ecef;
    }
    .nav-tabs .nav-link.active {
        color: #fff;
        background-color: #40c057;
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
        grid-template-columns: 2fr 1fr 2fr 1fr;
        gap: 2rem;
        align-items: center;
    }
    .customer-info {
        display: flex;
        flex-direction: column;
    }
    .customer-name {
        font-size: 1.1rem;
        font-weight: 600;
        color: #40c057;
        margin-bottom: 0.25rem;
    }
    .senior-name {
        color: #495057;
        font-size: 0.9rem;
    }
    .address-info {
        font-size: 0.9rem;
        color: #6c757d;
    }
    .distance-info {
        text-align: center;
        color: #495057;
    }
    .distance-value {
        font-weight: 600;
        font-size: 1.1rem;
        color: #40c057;
    }
    .distance-unit {
        font-size: 0.8rem;
        color: #6c757d;
    }
    .status-badge {
        display: inline-flex;
        align-items: center;
        padding: 0.5rem 1rem;
        border-radius: 20px;
        font-size: 0.9rem;
        font-weight: 500;
    }
    .status-pending {
        background-color: #fff3bf;
        color: #f08c00;
    }
    .status-active {
        background-color: #d3f9d8;
        color: #2b8a3e;
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
    @media (max-width: 768px) {
        .contract-main {
            grid-template-columns: 1fr;
            gap: 1rem;
        }
        .contract-item {
            flex-direction: column;
            align-items: flex-start;
        }
        .action-btn {
            margin-top: 1rem;
            width: 100%;
            text-align: center;
        }
    }
</style>

<div class="container mt-4">
    <!-- 탭 -->
    <ul class="nav nav-tabs">
        <li class="nav-item">
            <a class="nav-link <c:if test='${param.status == null || param.status == ""}'>active</c:if>'"
               href="/careworker/contracts">전체 보기</a>
        </li>
        <li class="nav-item">
            <a class="nav-link <c:if test='${param.status == "PENDING"}'>active</c:if>'"
               href="/careworker/contracts?status=PENDING">대기 중</a>
        </li>
        <li class="nav-item">
            <a class="nav-link <c:if test='${param.status == "ACTIVE"}'>active</c:if>'"
               href="/careworker/contracts?status=ACTIVE">매칭 완료</a>
        </li>
    </ul>

    <!-- 리스트 -->
    <div class="contracts-list">
        <c:forEach var="details" items="${contractsWithDetails}">
            <div class="contract-item">
                <div class="contract-main">
                    <div class="customer-info">
                        <span class="customer-name">${details.user.userName} 고객님</span>
                        <span class="senior-name">${details.senior.seniorName} 어르신</span>
                    </div>
                    <div class="distance-info">
                        <span class="distance-value">${details.distance}</span>
                    </div>
                    <div class="address-info">
                        <div>${details.senior.seniorStreetAddr}</div>
                        <div>생년월일: ${details.senior.seniorBirth}</div>
                    </div>
                    <div class="status-info">
                        <span class="status-badge
                            <c:choose>
                                <c:when test="${details.contract.contractStatus == 'PENDING'}">status-pending</c:when>
                                <c:when test="${details.contract.contractStatus == 'ACTIVE'}">status-active</c:when>
                            </c:choose>">
                            <c:choose>
                                <c:when test="${details.contract.contractStatus == 'PENDING'}">대기 중</c:when>
                                <c:when test="${details.contract.contractStatus == 'ACTIVE'}">매칭 완료</c:when>
                                <c:otherwise>${details.contract.contractStatus}</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                </div>
                <a href="/careworker/contract?contractId=${details.contract.contractId}" class="action-btn">
                    자세히 보기
                </a>
            </div>
        </c:forEach>
    </div>
</div>