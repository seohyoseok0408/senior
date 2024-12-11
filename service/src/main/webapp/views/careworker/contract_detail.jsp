<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap');

    :root {
        --primary: #5a67d8;
        --primary-light: #e6e8ff;
        --primary-dark: #4c51bf;
        --secondary: #7c3aed;
        --secondary-light: #ede9fe;
        --secondary-dark: #6d28d9;
        --disabled: #a0aec0;
        --background: #f7fafc;
        --text: #2d3748;
        --text-light: #718096;
        --border: #e2e8f0;
        --white: #ffffff;
        --shadow: 0 4px 6px rgba(90, 103, 216, 0.1);
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
        transition: all 0.3s ease;
    }

    .section:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
    }

    .section-header {
        background-color: var(--primary);
        color: var(--white);
        padding: 1.5rem 2rem;
        font-size: 1.8rem;
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
        align-items: stretch;
        gap: 2rem;
        margin-bottom: 2rem;
        background-color: var(--primary-light);
        padding: 2rem;
        border-radius: 15px;
        transition: all 0.3s ease;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    .profile-section:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
    }

    .profile-image-container {
        flex: 0 0 auto;
        position: relative;
        width: 200px;
        height: 200px;
        border-radius: 50%;
        overflow: hidden;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        transition: all 0.3s ease;
    }

    .profile-image-container::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background-color: rgba(90, 103, 216, 0.5);
        opacity: 0;
        transition: opacity 0.3s ease;
    }

    .profile-image-container:hover::before {
        opacity: 1;
    }

    .profile-image {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: all 0.3s ease;
    }

    .profile-image-container:hover .profile-image {
        transform: scale(1.1) rotate(5deg);
    }

    .profile-info {
        flex: 1;
        display: flex;
        flex-direction: column;
        justify-content: center;
    }

    .profile-info h3 {
        color: var(--primary);
        margin: 0 0 1rem;
        font-size: 2.2rem;
        font-weight: 700;
    }

    .info-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 1.5rem;
    }

    .cd-info-item {
        background: var(--white);
        padding: 1.2rem;
        border-radius: 12px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        transition: all 0.3s ease;
    }

    .cd-info-item:hover {
        transform: translateY(-3px);
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
    }

    .cd-info-label {
        font-size: 0.9rem;
        color: var(--text-light);
        margin-bottom: 0.5rem;
        text-transform: uppercase;
        letter-spacing: 0.05em;
    }

    .cd-info-value {
        font-size: 1.1rem;
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
        box-shadow: 0 0 0 3px rgba(0, 121, 107, 0.2);
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
    }

    .btn-success:disabled {
        background-color: var(--disabled);
        color: var(--white);
        opacity: 0.7;
        cursor: not-allowed;
    }

    .btn-secondary {
        background-color: var(--secondary);
        color: var(--white);
    }

    .btn-secondary:hover {
        background-color: var(--secondary-dark);
    }

    .badge {
        display: inline-block;
        padding: 0.5em 1em;
        font-size: 0.75rem;
        font-weight: 700;
        line-height: 1;
        text-align: center;
        white-space: nowrap;
        vertical-align: baseline;
        border-radius: 0.25rem;
        transition: all 0.3s ease;
    }

    .bg-success {
        background-color: var(--primary);
        color: var(--white);
    }

    .bg-secondary {
        background-color: var(--secondary);
        color: var(--white);
    }

    .btn:disabled {
        opacity: 0.7;
        cursor: not-allowed;
    }

    @media (max-width: 768px) {
        .profile-section {
            flex-direction: column;
            align-items: center;
            text-align: center;
        }

        .profile-image-container {
            margin-bottom: 1rem;
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
                <div class="profile-image-container">
                    <img src="/imgs/senior/${contractDetails.senior.seniorProfile}"
                         alt="${contractDetails.senior.seniorName} 어르신 프로필"
                         class="profile-image">
                </div>
                <div class="profile-info">
                    <h3>${contractDetails.senior.seniorName} 어르신</h3>
                    <div class="info-grid">
                        <div class="cd-info-item">
                            <div class="cd-info-label">생년월일</div>
                            <div class="cd-info-value">${contractDetails.senior.seniorBirth}</div>
                        </div>
                        <div class="cd-info-item">
                            <div class="cd-info-label">주소</div>
                            <div class="cd-info-value">${contractDetails.senior.seniorStreetAddr}</div>
                        </div>
                    </div>
                </div>
            </div>

            <form>
                <input type="hidden" id="contractId" value="${contractDetails.contract.contractId}">
                <div class="form-grid">
                    <div class="form-group">
                        <label class="form-label" for="contractPrice">계약 금액 (원)</label>
                        <input type="number" class="form-control" id="contractPrice" value="${contractDetails.contractPrice}">
                    </div>
                </div>

                <div style="text-align: center; margin-top: 2rem;">
                    <c:choose>
                        <c:when test="${contractDetails.contract.contractStatus == 'PENDING'}">
                            <button type="button" class="btn btn-success" id="btn-approve">계약 수락하기</button>
                        </c:when>
                        <c:when test="${contractDetails.contract.contractStatus == 'ACTIVE'}">
                            <button type="button" class="btn btn-success" disabled>계약 활성화됨</button>
                        </c:when>
                        <c:otherwise>
                            <button type="button" class="btn btn-secondary" disabled>계약 상태: ${contractDetails.contract.contractStatus}</button>
                        </c:otherwise>
                    </c:choose>
                    <a href="contracts" class="btn btn-secondary" style="margin-left: 1rem;">목록으로</a>
                </div>
            </form>

        </div>
    </div>
</div>

<script src="/js/contract_detail.js"></script>

