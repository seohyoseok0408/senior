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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar/main.min.css" />
<script src='/js/index.global.js'></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@fullcalendar/google-calendar@6.1.15/index.global.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@fullcalendar/rrule@6.1.15/index.global.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@fullcalendar/rrule@6.1.15/index.global.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/rrule@2.6.4/dist/es5/rrule.min.js"></script>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');

        // JavaScript로 전달된 JSON 데이터를 파싱
        const eventsData = JSON.parse('${schedulesJson}');

        // FullCalendar 초기화
        var calendar = new FullCalendar.Calendar(calendarEl, {
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,timeGridWeek,timeGridDay'
            },
            initialDate: '2024-12-01',
            navLinks: true, // can click day/week names to navigate views
            selectable: true,
            selectMirror: true,
            select: function(arg) {
                var title = prompt('Event Title:');
                if (title) {
                    calendar.addEvent({
                        title: title,
                        start: arg.start,
                        end: arg.end,
                        allDay: arg.allDay
                    })
                }
                calendar.unselect()
            },
            eventClick: function(arg) {
                if (confirm('Are you sure you want to delete this event?')) {
                    arg.event.remove()
                }
            },
            editable: true,
            dayMaxEvents: true, // allow "more" link when too many events
            events: eventsData.map(event => ({
                title: event.scheduleTitle,
                start: event.scheduleStartDatetime,
                end: event.scheduleEndDatetime,
                description: event.scheduleDescription, // FullCalendar에서 description은 커스텀
                allDay: false // 필요 시 event에서 allDay 값을 계산해 넣을 수 있음
            }))
        });

        calendar.render();
    });
</script>

