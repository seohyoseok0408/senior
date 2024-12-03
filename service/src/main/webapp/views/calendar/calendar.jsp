<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="content-body">
    <div class="container-fluid">
        <!-- Flexbox를 이용한 레이아웃 -->
        <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-top: 20px;">
            <!-- FullCalendar가 렌더링될 영역 -->
            <div id="calendar" style="flex: 0 0 70%; border: 1px solid #ddd; padding: 10px;"></div>

            <!-- 옆에 추가된 박스 -->
            <div style="flex: 0 0 28%; border: 1px solid #ddd; margin-left: 10px; padding: 10px; background-color: #f9f9f9;">
                <h2>추가 정보 박스</h2>
                <p>여기에 추가할 내용을 작성하세요.</p>
                <ul>
                    <li>예: 캘린더 관련 정보</li>
                    <li>예: 버튼 또는 기타 UI 요소</li>
                </ul>
            </div>
        </div>
    </div>

    <!-- 테스트용 버튼 -->
    <div style="margin-top: 20px;">
        <button onclick="location.reload()">페이지 새로고침</button>
    </div>
</div>

<!-- FullCalendar 스크립트 및 스타일 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.css" />
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@fullcalendar/google-calendar@6.1.15/index.global.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            googleCalendarApiKey: 'AIzaSyDg2saqO_a9atDxi182PINGustuRV2KU0A',
            events: {
                googleCalendarId: '0f14794759b325ef3e3fa62244d491fedb96c4c7d548aa6f6a3cff0d95ea58ed@group.calendar.google.com'
            },
            eventDidMount: function (info) {
                // FullCalendar가 처리한 이벤트 객체에서 확장 속성 확인
                const event = info.event;
                const extendedProps = event.extendedProps;

                // 로그로 출력
                console.log("=== 이벤트 데이터 ===");
                console.log("ID:", event.id);
                console.log("상태:", extendedProps.status);
                console.log("제목:", event.title);
                console.log("설명:", extendedProps.description);
                console.log("위치:", extendedProps.location);
                console.log("시작 시간:", event.start);
                console.log("끝 시간:", event.end);
                console.log("반복 규칙:", extendedProps.recurrence);
                console.log("참석자:", extendedProps.attendees);
                console.log("리마인더:", extendedProps.reminders);
                console.log("=====================");
            },
            eventDataTransform: function (rawEvent) {
                // 원본 데이터를 변환하거나 필요에 따라 확인
                console.log("원본 이벤트 데이터:", rawEvent);
                return rawEvent; // 변형 없이 반환
            }
        });
        calendar.render();
    });
</script>

