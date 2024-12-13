<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap');

    :root {
        --primary: #2ecc71;
        --primary-light: #e8f8f5;
        --secondary: #27ae60;
        --background: #f9f9f9;
        --text: #2c3e50;
        --text-light: #7f8c8d;
        --border: #a5d6a7;
        --white: #ffffff;
        --shadow: 0 4px 6px rgba(46, 204, 113, 0.1);
        --transition: all 0.3s ease;
    }

    body {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: var(--background);
        color: var(--text);
        line-height: 1.6;
        margin: 0;
        padding: 0;
    }

    .container {
        max-width: 1400px;
        margin: 0 auto;
        padding: 2rem;
    }

    .dashboard {
        display: grid;
        grid-template-columns: 1fr 2fr;
        gap: 2rem;
    }

    .card {
        background: var(--white);
        border-radius: 20px;
        box-shadow: var(--shadow);
        overflow: hidden;
        transition: var(--transition);
    }

    .card-header {
        background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
        color: var(--white);
        padding: 1.5rem 2rem;
        font-size: 1.5rem;
        font-weight: 700;
        text-align: center;
    }

    .card-body {
        padding: 2rem;
    }

    .profile-section {
        display: flex;
        flex-direction: column;
        align-items: center;
        text-align: center;
    }

    .profile-image {
        width: 200px;
        height: 200px;
        border-radius: 50%;
        object-fit: cover;
        border: 5px solid var(--primary);
        box-shadow: var(--shadow);
        margin-bottom: 1.5rem;
    }

    .profile-name {
        font-size: 2rem;
        color: var(--primary);
        margin-bottom: 0.5rem;
    }

    .profile-details {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 1rem;
        margin-top: 1.5rem;
    }

    .profile-item {
        background: var(--primary-light);
        padding: 1rem;
        border-radius: 10px;
        transition: var(--transition);
    }

    .profile-item:hover {
        transform: translateY(-3px);
        box-shadow: var(--shadow);
    }

    .profile-label {
        font-size: 0.9rem;
        color: var(--text-light);
        margin-bottom: 0.25rem;
        text-transform: uppercase;
    }

    .profile-value {
        font-weight: 600;
        color: var(--text);
    }

    .contract-section {
        display: flex;
        flex-direction: column;
        gap: 1.5rem;
    }

    .form-group {
        display: flex;
        flex-direction: column;
        gap: 0.5rem;
    }

    .form-label {
        font-weight: bold;
        color: var(--text-light);
    }

    .form-control {
        padding: 0.5rem;
        border: 1px solid var(--border);
        border-radius: 5px;
        font-size: 1rem;
    }

    .btn {
        display: block;
        padding: 15px 20px;
        border: none;
        border-radius: 10px;
        font-size: 1.2rem;
        font-weight: 600;
        cursor: pointer;
        transition: var(--transition);
        text-decoration: none;
        text-align: center;
        width: 100%;
        margin-top: 1rem;
        height: 58px;
    }

    .btn-primary {
        background-color: var(--primary);
        color: var(--white);
    }

    .btn-primary:hover {
        background-color: var(--secondary);
        transform: translateY(-2px);
    }

    .btn-secondary {
        background-color: var(--text-light);
        color: var(--white);
    }

    .btn-secondary:hover {
        background-color: var(--text);
        transform: translateY(-2px);
    }
</style>

<div class="container">
    <div class="dashboard">
        <div class="card">
            <div class="card-header">
                보호사 프로필 정보
            </div>
            <div class="card-body">
                <div class="profile-section">
                    <img src="/imgs/careworker/${careworker.cwProfile}" alt="${careworker.cwName} 프로필"
                         class="profile-image">
                    <h2 class="profile-name">${careworker.cwName}</h2>
                    <div class="profile-details">
                        <div class="profile-item">
                            <div class="profile-label">연락처</div>
                            <div class="profile-value">${careworker.cwTel}</div>
                        </div>
                        <div class="profile-item">
                            <div class="profile-label">이메일</div>
                            <div class="profile-value">${careworker.cwEmail}</div>
                        </div>
                        <div class="profile-item">
                            <div class="profile-label">경력</div>
                            <div class="profile-value">${careworker.cwExperience}년</div>
                        </div>
                        <div class="profile-item">
                            <div class="profile-label">소개</div>
                            <div class="profile-value">${careworker.cwIntro}</div>
                        </div>
                        <div class="profile-item">
                            <div class="profile-label">휴일</div>
                            <div class="profile-value">${careworker.cwHoliday}</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="card">
            <div class="card-header">
                계약 신청
            </div>
            <div class="card-body">
                <div class="contract-section">
                    <div class="form-group">
                        <label for="contractStartDate" class="form-label">시작 날짜</label>
                        <input type="date" id="contractStartDate" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="contractEndDate" class="form-label">종료 날짜</label>
                        <input type="date" id="contractEndDate" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="contractAmount" class="form-label">금액</label>
                        <input type="number" id="contractAmount" class="form-control" placeholder="계약 금액">
                    </div>
                    <div class="form-group">
                        <label for="contractInfo" class="form-label">계약 내용</label>
                        <input id="contractInfo" class="form-control" placeholder="계약 내용을 입력하세요">
                    </div>
                </div>
                <div class="contract-buttons">
                    <input type="hidden" id="careworkerId" value="${careworker.cwId}">
                    <input type="hidden" id="seniorId" value="${seniorId}">
                    <button type="button" id="contract-btn" class="cwd-btn cwd-btn-primary">계약 신청</button>
                    <a href="/user/careworkers" class="btn btn-secondary">목록으로</a>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>
<script src="/js/careworker.js"></script>


