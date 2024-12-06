<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="content-body">
    <div class="container-fluid">
        <!-- Flexbox를 이용한 레이아웃 -->
        <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-top: 20px;">
            <!-- FullCalendar가 렌더링될 영역 -->
            <div id="calendar" style="flex: 0 0 70%; border: 1px solid #ddd; padding: 10px;"></div>
        </div>
    </div>
</div>

<!-- 모달 HTML 추가 -->
<div class="modal fade" id="scheduleModal" tabindex="-1" aria-labelledby="scheduleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="scheduleModalLabel">일정 추가</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="modalScheduleForm">
                    <div style="margin-bottom: 10px;">
                        <label for="modalScheduleTitle">제목</label>
                        <input type="text" id="modalScheduleTitle" name="scheduleTitle" class="form-control" required>
                    </div>
                    <div style="margin-bottom: 10px;">
                        <label for="modalScheduleStartDate">시작 날짜</label>
                        <input type="date" id="modalScheduleStartDate" name="scheduleStartDate" class="form-control"
                               readonly>
                    </div>
                    <div style="margin-bottom: 10px;">
                        <label for="modalScheduleStartTime">시작 시간</label>
                        <input type="time" id="modalScheduleStartTime" name="scheduleStartTime" class="form-control"
                               required>
                    </div>
                    <div style="margin-bottom: 10px;">
                        <label for="modalScheduleEndDate">종료 날짜</label>
                        <input type="date" id="modalScheduleEndDate" name="scheduleEndDate" class="form-control"
                               readonly>
                    </div>
                    <div style="margin-bottom: 10px;">
                        <label for="modalScheduleEndTime">종료 시간</label>
                        <input type="time" id="modalScheduleEndTime" name="scheduleEndTime" class="form-control"
                               required>
                    </div>
                    <div style="margin-bottom: 10px;">
                        <label for="modalScheduleDescription">설명</label>
                        <textarea id="modalScheduleDescription" name="scheduleDescription" class="form-control"
                                  rows="4"></textarea>
                    </div>
                    <button type="button" id="saveScheduleBtn" class="btn btn-primary" style="width: 100%;">일정 추가
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap CSS & JS 추가 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- FullCalendar 스크립트 및 스타일 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar/main.min.css"/>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>

<!-- FullCalendar 스크립트 -->
<script>
    // 날짜 및 시간을 DB 형식으로 변환하는 함수
    function formatDateTime(date, time) {
        // 공백 제거
        time = time.trim();

        // 시간과 분 분리
        const parts = time.split(':');

        if (parts.length !== 2) {
            console.error('Time splitting failed. Parts:', parts);
            return null;
        }

        const [hourPart, minutePart] = parts;

        if (!hourPart || !minutePart) {
            console.error('Hour or minute part is missing:', hourPart, minutePart);
            return null;
        }

        const hours = String(hourPart).padStart(2, '0');
        const minutes = String(minutePart).padStart(2, '0');
        const seconds = '00'; // 초는 고정값

        // 최종 포맷
        const formattedDateTime = date + "T" + hours + ":" + minutes + ":" + seconds;
        return formattedDateTime;
    }

    document.addEventListener('DOMContentLoaded', function () {
        var calendarEl = document.getElementById('calendar');
        const eventsData = JSON.parse('${schedulesJson}');

        var calendar = new FullCalendar.Calendar(calendarEl, {
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,timeGridWeek,timeGridDay'
            },
            initialDate: '2024-12-01',
            navLinks: true,
            selectable: true,
            selectMirror: true,
            events: eventsData.map(event => ({
                title: event.scheduleTitle,
                start: event.scheduleStartDatetime,
                end: event.scheduleEndDatetime,
                description: event.scheduleDescription,
                allDay: false
            })),
            select: function (arg) {
                $('#scheduleModal').modal('show');
                document.getElementById('modalScheduleStartDate').value = arg.startStr;
                var endDate = new Date(arg.end);
                endDate.setDate(endDate.getDate() - 1);
                document.getElementById('modalScheduleEndDate').value = endDate.toISOString().split('T')[0];
            },
            editable: true,
            dayMaxEvents: true,
        });

        calendar.render();

        document.getElementById('saveScheduleBtn').addEventListener('click', function () {
            var title = document.getElementById('modalScheduleTitle').value.trim();
            var startDate = document.getElementById('modalScheduleStartDate').value;
            var startTime = document.getElementById('modalScheduleStartTime').value;
            var endDate = document.getElementById('modalScheduleEndDate').value;
            var endTime = document.getElementById('modalScheduleEndTime').value;
            var description = document.getElementById('modalScheduleDescription').value.trim();

            if (!title || !startDate || !startTime || !endDate || !endTime || !description) {
                alert("모든 필드를 채워주세요.");
                console.log("Missing fields:", {title, startDate, startTime, endDate, endTime, description});
                return;
            }

            const startDateTime = formatDateTime(startDate, startTime);
            const endDateTime = formatDateTime(endDate, endTime);

            if (!startDateTime || !endDateTime) {
                alert("날짜와 시간 형식이 올바르지 않습니다.");
                return;
            }

            const scheduleData = {
                scheduleTitle: title,
                scheduleStartDatetime: startDateTime,
                scheduleEndDatetime: endDateTime,
                scheduleDescription: description
            };

            console.log("Prepared scheduleData:", JSON.stringify(scheduleData));

            $.ajax({
                url: '/api/calendar/saveUserSchedule',
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(scheduleData),
                success: function (response) {
                    console.log("Server Response:", response);
                    alert("유저 일정이 성공적으로 저장되었습니다.");
                },
                error: function (error) {
                    console.error("AJAX Error:", error.responseText || error.statusText);
                    alert("유저 일정 저장 중 오류가 발생했습니다.");
                }
            });

            $('#scheduleModal').modal('hide');
        });
    });
</script>


