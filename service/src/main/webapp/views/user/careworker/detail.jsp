<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap');

    .cwd-wrapper {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: #ffffff;
        color: #333;
        line-height: 1.6;
        padding: 2rem;
    }

    .cwd-container {
        max-width: 1200px;
        margin: 0 auto;
        background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
        border-radius: 20px;
        overflow: hidden;
        box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
    }

    .cwd-header {
        background: linear-gradient(60deg, #2c786c 0%, #37a794 100%);
        padding: 2rem;
        color: #fff;
        text-align: center;
        position: relative;
    }

    .cwd-header::after {
        content: '';
        position: absolute;
        bottom: -50px;
        left: 0;
        right: 0;
        height: 50px;
        background: inherit;
        transform: skewY(-4deg);
    }

    .cwd-title {
        font-size: 2.5rem;
        font-weight: 700;
        margin: 0;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
    }

    .cwd-content {
        display: flex;
        flex-wrap: wrap;
        padding: 3rem 2rem;
        position: relative;
        z-index: 1;
    }

    .cwd-profile {
        flex: 1;
        min-width: 250px;
        text-align: center;
    }

    .cwd-profile-image {
        width: 200px;
        height: 200px;
        border-radius: 50%;
        object-fit: cover;
        border: 5px solid #fff;
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        transition: all 0.3s ease;
    }

    .cwd-profile-image:hover {
        transform: scale(1.05) rotate(3deg);
        box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
    }

    .cwd-info {
        flex: 2;
        min-width: 300px;
    }

    .cwd-name {
        font-size: 2.2rem;
        color: #2c786c;
        margin-bottom: 1rem;
        display: flex;
        align-items: center;
        gap: 1rem;
    }

    .cwd-gender {
        font-size: 0.9rem;
        background-color: #37a794;
        color: #fff;
        padding: 0.25rem 1rem;
        border-radius: 20px;
        text-transform: uppercase;
    }

    .cwd-details {
        display: grid;
        gap: 1.5rem;
    }

    .cwd-detail-item {
        background-color: rgba(255, 255, 255, 0.8);
        border-radius: 10px;
        padding: 1.2rem;
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
    }

    .cwd-detail-item::before {
        content: '';
        position: absolute;
        top: -2px;
        left: -2px;
        right: -2px;
        bottom: -2px;
        background: linear-gradient(45deg, #2c786c, #37a794);
        z-index: -1;
        filter: blur(5px);
        opacity: 0;
        transition: opacity 0.3s ease;
    }

    .cwd-detail-item:hover {
        transform: translateY(-5px);
    }

    .cwd-detail-item:hover::before {
        opacity: 1;
    }

    .cwd-detail-label {
        font-weight: 600;
        color: #2c786c;
        margin-bottom: 0.5rem;
        display: block;
    }

    .cwd-detail-value {
        color: #333;
    }

    .cwd-buttons {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 1.5rem;
        padding: 40px;
    }

    .cwd-btn {
        padding: 0.75rem 2rem;
        border: none;
        border-radius: 25px;
        font-size: 1rem;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.3s ease;
        text-decoration: none;
        position: relative;
        overflow: hidden;
    }

    .cwd-btn::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(
                120deg,
                transparent,
                rgba(255, 255, 255, 0.3),
                transparent
        );
        transition: all 0.5s;
    }

    .cwd-btn:hover::before {
        left: 100%;
    }

    .cwd-btn-primary {
        background-color: #2c786c;
        color: #fff;
    }

    .cwd-btn-primary:hover {
        background-color: #37a794;
        box-shadow: 0 5px 15px rgba(44, 120, 108, 0.4);
    }

    .cwd-btn-secondary {
        background-color: #e0f2f1;
        color: #2c786c;
    }

    .cwd-btn-secondary:hover {
        background-color: #b2dfdb;
        box-shadow: 0 5px 15px rgba(55, 167, 148, 0.3);
    }

    .cwd-calendar-form-container {
        display: flex;
        justify-content: space-between;
        gap: 2rem;
        width: 100%;
    }

    .cwd-calendar {
        flex: 2;
        margin-top: 20px;
        background-color: #ffffff;
        border-radius: 10px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        padding: 20px;
    }

    .cwd-form-grid {
        flex: 1;
        display: grid;
        grid-template-columns: 1fr;
        gap: 1rem;
        margin-top: 2rem;
    }

    .cwd-form-group {
        display: flex;
        flex-direction: column;
    }

    .cwd-form-label {
        margin-bottom: 0.5rem;
        font-size: 0.9rem;
        text-align: center;
        font-weight: bold;
    }

    .cwd-form-control {
        padding: 0.6rem;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 0.9rem;
    }

    .cwd-button-container {
        display: flex;
        justify-content: center;
        gap: 1rem;
        margin-top: 1rem;
    }

    .cwd-gender {
        font-size: 0.9rem;
        background-color: #37a794;
        color: #fff;
        padding: 0.25rem 1rem;
        border-radius: 20px;
        text-transform: uppercase;
    }
</style>

<div class="cwd-wrapper">
    <div class="cwd-container">
        <header class="cwd-header">
            <h1 class="cwd-title">보호사 상세 정보</h1>
        </header>

        <div class="cwd-content">
            <div class="cwd-profile">
                <c:choose>
                    <c:when test="${not empty careworker.cwProfile}">
                        <img src="/imgs/careworker/${careworker.cwProfile}" class="cwd-profile-image"
                             alt="${careworker.cwName}">
                    </c:when>
                    <c:otherwise>
                        <img src="/static/images/default-profile.png" class="cwd-profile-image" alt="Default Profile">
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="cwd-info">
                <div class="cwd-name">
                    ${careworker.cwName}
                    <span class="cwd-gender">
                        <c:choose>
                            <c:when test="${senior.seniorGender == 'M'}">남성</c:when>
                            <c:otherwise>여성</c:otherwise>
                        </c:choose>
                    </span></div>

                <div class="cwd-details">
                    <div class="cwd-detail-item">
                        <span class="cwd-detail-label">연락처</span>
                        <span class="cwd-detail-value">${careworker.cwTel}</span>
                    </div>

                    <div class="cwd-detail-item">
                        <span class="cwd-detail-label">이메일</span>
                        <span class="cwd-detail-value">${careworker.cwEmail}</span>
                    </div>

                    <div class="cwd-detail-item">
                        <span class="cwd-detail-label">경력</span>
                        <span class="cwd-detail-value">${careworker.cwExperience}년</span>
                    </div>

                    <div class="cwd-detail-item">
                        <span class="cwd-detail-label">소개</span>
                        <span class="cwd-detail-value">${careworker.cwIntro}</span>
                    </div>

                    <div class="cwd-detail-item">
                        <span class="cwd-detail-label">휴일</span>
                        <span class="cwd-detail-value">${careworker.cwHoliday}</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="cwd-buttons">
            <div class="cwd-calendar-form-container">
                <div id="calendar" class="cwd-calendar"></div>
                <div class="cwd-form-grid">
                    <div class="cwd-form-group">
                        <label for="contractStartDate" class="cwd-form-label">시작 날짜</label>
                        <input type="date" id="contractStartDate" class="cwd-form-control">
                    </div>
                    <div class="cwd-form-group">
                        <label for="contractStartTime" class="cwd-form-label">시작 시간</label>
                        <input type="time" id="contractStartTime" class="cwd-form-control">
                    </div>
                    <div class="cwd-form-group">
                        <label for="contractEndDate" class="cwd-form-label">종료 날짜</label>
                        <input type="date" id="contractEndDate" class="cwd-form-control">
                    </div>
                    <div class="cwd-form-group">
                        <label for="contractEndTime" class="cwd-form-label">종료 시간</label>
                        <input type="time" id="contractEndTime" class="cwd-form-control">
                    </div>
                </div>
            </div>
            <input type="hidden" id="careworkerId" value="${careworker.cwId}">
            <input type="hidden" id="seniorId" value="${seniorId}"/>
            <div class="cwd-button-container">
                <button type="button" id="contract-btn" class="cwd-btn cwd-btn-primary">계약 신청</button>
                <a href="/user/careworkers" class="cwd-btn cwd-btn-secondary">목록으로</a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>
<script src="/js/careworker.js"></script>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,timeGridWeek,timeGridDay'
            },
            locale: 'ko',
            buttonText: {
                today: '오늘',
                month: '월',
                week: '주',
                day: '일'
            },
            events: [
                // 여기에 이벤트를 추가할 수 있습니다.
            ],
            eventClick: function (info) {
                alert('이벤트: ' + info.event.title);
            },
            dateClick: function (info) {
                alert('선택한 날짜: ' + info.dateStr);
            }
        });
        calendar.render();
    });
</script>

