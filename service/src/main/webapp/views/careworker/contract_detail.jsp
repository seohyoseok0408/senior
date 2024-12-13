<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap');

    :root {
        --scd-primary: #2ecc71;
        --scd-primary-dark: #27ae60;
        --scd-secondary: #3498db;
        --scd-background: #f0f4f8;
        --scd-card-bg: #ffffff;
        --scd-text: #2c3e50;
        --scd-text-light: #7f8c8d;
        --scd-border: #e0e0e0;
        --scd-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    body {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: var(--scd-background);
        color: var(--scd-text);
        line-height: 1.6;
        margin: 0;
        padding: 0;
    }

    .scd-container {
        padding: 2rem;
        max-width: 1200px;
        margin: 0 auto;
    }

    .scd-card {
        background: var(--scd-card-bg);
        border-radius: 12px;
        box-shadow: var(--scd-shadow);
        overflow: hidden;
        margin-bottom: 2rem;
    }

    .scd-card-header {
        background: var(--scd-primary);
        color: white;
        padding: 1.5rem;
        font-size: 1.5rem;
        font-weight: 700;
        text-align: center;
    }

    .scd-card-body {
        padding: 2rem;
    }

    .scd-profile {
        display: flex;
        align-items: center;
        margin-bottom: 2rem;
        background-color: #e8f6e9;
        padding: 1.5rem;
        border-radius: 8px;
    }

    .scd-profile-image {
        width: 120px;
        height: 120px;
        border-radius: 50%;
        object-fit: cover;
        border: 4px solid var(--scd-primary);
        margin-right: 2rem;
    }

    .scd-profile-info h2 {
        color: var(--scd-primary);
        margin: 0 0 0.5rem;
        font-size: 1.8rem;
    }

    .scd-profile-info p {
        margin: 0;
        color: var(--scd-text);
    }

    .scd-info-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 1.5rem;
        margin-bottom: 2rem;
    }

    .scd-info-item {
        background: #f8f9fa;
        padding: 1.5rem;
        border-radius: 8px;
        border-left: 4px solid var(--scd-primary);
        transition: all 0.3s ease;
    }

    .scd-info-item:hover {
        transform: translateY(-5px);
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    }

    .scd-info-label {
        font-size: 0.9rem;
        color: var(--scd-text-light);
        margin-bottom: 0.5rem;
        text-transform: uppercase;
        letter-spacing: 0.05em;
    }

    .scd-info-value {
        font-size: 1.1rem;
        font-weight: 500;
        color: var(--scd-text);
        max-height: 100px;
        overflow-y: auto;
        word-wrap: break-word;
    }

    .scd-map-container {
        height: 400px;
        border-radius: 8px;
        overflow: hidden;
        margin-bottom: 2rem;
        box-shadow: var(--scd-shadow);
        margin-top: 40px;
    }

    #map {
        width: 100%;
        height: 100%;
    }

    .scd-btn-container {
        display: flex;
        justify-content: center;
        gap: 1rem;
    }

    .scd-btn {
        padding: 0.75rem 1.5rem;
        border: none;
        border-radius: 8px;
        font-size: 1rem;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        text-transform: uppercase;
    }

    .scd-btn-primary {
        background-color: var(--scd-primary);
        color: white;
    }

    .scd-btn-primary:hover {
        background-color: var(--scd-primary-dark);
    }

    .scd-btn-secondary {
        background-color:#7f8c8d;
        color: white;
    }

    .scd-btn-secondary:hover {
        background-color: #2980b9;
    }

    .scd-btn:disabled {
        opacity: 0.7;
        cursor: not-allowed;
    }

    @media (max-width: 768px) {
        .scd-profile {
            flex-direction: column;
            text-align: center;
        }

        .scd-profile-image {
            margin-right: 0;
            margin-bottom: 1rem;
        }

        .scd-btn-container {
            flex-direction: column;
        }

        .scd-btn {
            width: 100%;
        }
    }
</style>

<div class="scd-container">
    <div class="scd-card">
        <div class="scd-card-header">
            ${contractDetails.user.userName} 고객님의 보호사 계약 정보
        </div>
        <div class="scd-card-body">
            <div class="scd-profile">
                <img src="/imgs/senior/${contractDetails.senior.seniorProfile}"
                     alt="${contractDetails.senior.seniorName} 어르신 프로필"
                     class="scd-profile-image"
                     onerror="this.src='/imgs/default-profile.png'">
                <div class="scd-profile-info">
                    <h2>${contractDetails.senior.seniorName} 어르신</h2>
                    <p><strong>생년월일:</strong> ${contractDetails.senior.seniorBirth}</p>
                    <p><strong>주소:</strong> ${contractDetails.senior.seniorStreetAddr}</p>
                    <p><strong>전화번호:</strong> ${contractDetails.senior.seniorTel}</p>
                </div>
            </div>

            <div class="scd-info-grid">
                <div class="scd-info-item">
                    <div class="scd-info-label">계약 시작일</div>
                    <div class="scd-info-value">
                        <fmt:parseDate value="${contractDetails.schedule.scheduleStartDatetime}"
                                       pattern="yyyy-MM-dd'T'HH:mm" var="parseStart" type="both"/>
                        <fmt:formatDate pattern="yyyy년 MM월 dd일" value="${parseStart}"/>
                    </div>
                </div>
                <div class="scd-info-item">
                    <div class="scd-info-label">계약 종료일</div>
                    <div class="scd-info-value">
                        <fmt:parseDate value="${contractDetails.schedule.scheduleEndDatetime}"
                                       pattern="yyyy-MM-dd'T'HH:mm" var="parseEnd" type="both"/>
                        <fmt:formatDate pattern="yyyy년 MM월 dd일" value="${parseEnd}"/>
                    </div>
                </div>
                <div class="scd-info-item">
                    <div class="scd-info-label">계약 금액</div>
                    <div class="scd-info-value">
                        <fmt:formatNumber type="number" pattern="###,###원" value="${contractDetails.contract.contractPrice}" />
                    </div>
                </div>
            </div>
            <div class="scd-info-item">
                <div class="scd-info-label">유의사항</div>
                <div class="scd-info-value">${contractDetails.contract.contractInfo}</div>
            </div>


            <div class="scd-map-container">
                <div id="map"
                     data-cw-lat="${contractDetails.careworker.cwLatitude}"
                     data-cw-lng="${contractDetails.careworker.cwLongitude}"
                     data-sr-lat="${contractDetails.senior.seniorLatitude}"
                     data-sr-lng="${contractDetails.senior.seniorLongitude}">
                </div>
            </div>

            <div class="scd-btn-container">
                <c:choose>
                    <c:when test="${contractDetails.contract.contractStatus == 'PENDING'}">
                        <button type="button" class="scd-btn scd-btn-primary" id="btn-approve">계약 수락</button>
                        <button type="button" class="scd-btn scd-btn-secondary" id="btn-reject">거절</button>
                    </c:when>
                    <c:when test="${contractDetails.contract.contractStatus == 'ACTIVE'}">
                        <button type="button" class="scd-btn scd-btn-primary" disabled>계약 활성화됨</button>
                    </c:when>
                    <c:otherwise>
                        <button type="button" class="scd-btn scd-btn-secondary" disabled>
                            계약 상태: ${contractDetails.contract.contractStatus}
                        </button>
                    </c:otherwise>
                </c:choose>
                <a href="contracts" class="scd-btn scd-btn-secondary">목록</a>
            </div>
        </div>
    </div>
</div>

<input type="hidden" value="${contractDetails.contract.contractId}" id="contractId">
<input type="hidden" id="cwId" value="${contractDetails.careworker.cwId}">
<input type="hidden" id="userId" value="${contractDetails.user.userId}">

<script src="/js/contract_detail.js"></script>

