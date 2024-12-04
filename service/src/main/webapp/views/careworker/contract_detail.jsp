<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap');

    :root {
        --primary: #5a67d8;
        --primary-dark: #4c51bf;
        --background: #f7fafc;
        --text: #2d3748;
        --text-light: #718096;
        --border: #e2e8f0;
        --white: #ffffff;
        --shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    body {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: var(--background);
        color: var(--text);
        line-height: 1.6;
    }

    .container {
        max-width: 1200px;
        margin: 2rem auto;
        padding: 0 1rem;
    }

    .section {
        background: var(--white);
        border-radius: 15px;
        box-shadow: var(--shadow);
        margin-bottom: 2rem;
        overflow: hidden;
        transition: transform 0.3s ease;
    }

    .section:hover {
        transform: translateY(-5px);
    }

    .section-header {
        background: linear-gradient(135deg, var(--primary) 0%, #7f9cf5 100%);
        color: var(--white);
        padding: 1.5rem 2rem;
        font-size: 1.5rem;
        font-weight: 700;
    }

    .section-content {
        padding: 2rem;
    }

    .map-container {
        height: 400px;
        border-radius: 10px;
        overflow: hidden;
        margin-bottom: 2rem;
        box-shadow: var(--shadow);
    }

    #map {
        width: 100%;
        height: 100%;
    }

    .profile-section {
        display: flex;
        align-items: center;
        gap: 2rem;
        margin-bottom: 2rem;
        background-color: #ebf4ff;
        padding: 1.5rem;
        border-radius: 10px;
    }

    .profile-image {
        width: 150px;
        height: 150px;
        border-radius: 50%;
        object-fit: cover;
        border: 4px solid var(--primary);
        box-shadow: var(--shadow);
    }

    .profile-info h3 {
        color: var(--primary);
        margin: 0 0 1rem;
        font-size: 1.8rem;
    }

    .info-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 1rem;
    }

    .info-item {
        background: var(--white);
        padding: 1rem;
        border-radius: 8px;
        box-shadow: var(--shadow);
        transition: transform 0.3s ease;
    }

    .info-item:hover {
        transform: translateY(-3px);
    }

    .info-label {
        font-size: 0.875rem;
        color: var(--text-light);
        margin-bottom: 0.25rem;
        text-transform: uppercase;
    }

    .info-value {
        font-weight: 600;
        color: var(--text);
    }

    .form-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 1.5rem;
        margin-bottom: 2rem;
    }

    .form-group {
        display: flex;
        flex-direction: column;
        gap: 0.5rem;
    }

    .form-label {
        font-size: 1rem;
        font-weight: 600;
        color: var(--text);
    }

    .form-control {
        width: 100%;
        padding: 0.75rem;
        border: 2px solid var(--border);
        border-radius: 8px;
        font-size: 1rem;
        transition: all 0.3s ease;
    }

    .form-control:focus {
        outline: none;
        border-color: var(--primary);
        box-shadow: 0 0 0 3px rgba(90, 103, 216, 0.2);
    }

    .btn {
        padding: 0.75rem 1.5rem;
        border: none;
        border-radius: 8px;
        font-size: 1rem;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        text-transform: uppercase;
    }

    .btn-success {
        background-color: var(--primary);
        color: var(--white);
    }

    .btn-success:hover {
        background-color: var(--primary-dark);
        transform: translateY(-2px);
        box-shadow: var(--shadow);
    }

    .btn-secondary {
        background-color: var(--text-light);
        color: var(--white);
    }

    .btn-secondary:hover {
        background-color: var(--text);
        transform: translateY(-2px);
        box-shadow: var(--shadow);
    }

    @media (max-width: 768px) {
        .profile-section {
            flex-direction: column;
            text-align: center;
        }

        .form-grid {
            grid-template-columns: 1fr;
        }
    }
</style>

<div class="container">
    <div class="section">
        <div class="section-header">
            ${contractDetails.user.userName} 고객님의 보호사
        </div>
        <div class="section-content">
            <div class="map-container">
                <div id="map"
                     data-cw-lat="${contractDetails.careworker.cwLatitude}"
                     data-cw-lng="${contractDetails.careworker.cwLongitude}"
                     data-sr-lat="${contractDetails.senior.seniorLatitude}"
                     data-sr-lng="${contractDetails.senior.seniorLongitude}">
                </div>
            </div>

            <div class="profile-section">
                <img src="/imgs/senior/${contractDetails.senior.seniorProfile}"
                     alt="${contractDetails.senior.seniorName} 어르신 프로필"
                     class="profile-image">
                <div class="profile-info">
                    <h3>${contractDetails.senior.seniorName} 어르신</h3>
                    <div class="info-grid">
                        <div class="info-item">
                            <div class="info-label">생년월일</div>
                            <div class="info-value">${contractDetails.senior.seniorBirth}</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">주소</div>
                            <div class="info-value">${contractDetails.senior.seniorStreetAddr}</div>
                        </div>
                    </div>
                </div>
            </div>

            <form>
                <input type="hidden" id="contractId" value="${contractDetails.contract.contractId}">
                <div class="form-grid">
                    <div class="form-group">
                        <label class="form-label" for="contractStartDate">계약 시작일</label>
                        <input type="date" class="form-control" id="contractStartDate"
                               value="${contractDetails.contractStartDate}">
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="contractEndDate">계약 종료일</label>
                        <input type="date" class="form-control" id="contractEndDate"
                               value="${contractDetails.contractEndDate}">
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="contractPrice">계약 금액 (원)</label>
                        <input type="number" class="form-control" id="contractPrice"
                               value="${contractDetails.contractPrice}">
                    </div>
                </div>

                <div style="text-align: center;">
                    <c:if test="${contractDetails.contract.contractStatus == 'PENDING'}">
                        <button type="button" class="btn btn-success" id="btn-approve">계약 수락하기</button>
                    </c:if>
                    <a href="/careworker/contracts" class="btn btn-secondary">목록으로 돌아가기</a>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="/js/contract_detail.js"></script>

