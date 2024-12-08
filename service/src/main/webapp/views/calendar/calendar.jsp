<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="content-body">
    <div class="container-fluid">
        <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-top: 20px;">
            <div id="calendar" style="flex: 0 0 70%; border: 1px solid #ddd; padding: 10px;"></div>
        </div>
    </div>
</div>

<div class="modal fade" id="scheduleAddModal" tabindex="-1" aria-labelledby="scheduleAddModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="scheduleAddModalLabel">일정 추가</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="modalAddScheduleForm">
                    <div style="margin-bottom: 10px;">
                        <label for="addScheduleTitle">제목</label>
                        <input type="text" id="addScheduleTitle" name="scheduleTitle" class="form-control" required>
                    </div>
                    <div style="margin-bottom: 10px;">
                        <label for="modalAddStartDate">시작 날짜</label>
                        <input type="date" id="modalAddStartDate" name="scheduleStartDate" class="form-control" readonly>
                    </div>
                    <div style="margin-bottom: 10px;">
                        <label for="modalAddStartTime">시작 시간</label>
                        <input type="time" id="modalAddStartTime" name="scheduleStartTime" class="form-control" required>
                    </div>
                    <div style="margin-bottom: 10px;">
                        <label for="modalAddEndDate">종료 날짜</label>
                        <input type="date" id="modalAddEndDate" name="scheduleEndDate" class="form-control" readonly>
                    </div>
                    <div style="margin-bottom: 10px;">
                        <label for="modalAddEndTime">종료 시간</label>
                        <input type="time" id="modalAddEndTime" name="scheduleEndTime" class="form-control" required>
                    </div>
                    <div style="margin-bottom: 10px;">
                        <label for="modalAddDescription">설명</label>
                        <textarea id="modalAddDescription" name="scheduleDescription" class="form-control" rows="4"></textarea>
                    </div>
                    <button type="button" id="saveScheduleBtn" class="btn btn-primary" style="width: 100%;">일정 추가</button>
                </form>
            </div>
        </div>
    </div>
</div>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar/main.min.css"/>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>

<script>
    function formatDateTime(date, time) {
        return date + "T" + time + ":00";
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
            select: function(arg) {
                document.getElementById('modalAddStartDate').value = arg.startStr;
                document.getElementById('modalAddEndDate').value = arg.endStr;
                $('#scheduleAddModal').modal('show');
            },
            editable: true,
            dayMaxEvents: true
        });

        calendar.render();

        document.getElementById('saveScheduleBtn').addEventListener('click', function () {
            var title = document.getElementById('addScheduleTitle').value.trim();
            var startDate = document.getElementById('modalAddStartDate').value;
            var startTime = document.getElementById('modalAddStartTime').value;
            var endDate = document.getElementById('modalAddEndDate').value;
            var endTime = document.getElementById('modalAddEndTime').value;
            var description = document.getElementById('modalAddDescription').value.trim();

            if (!title || !startDate || !startTime || !endDate || !endTime || !description) {
                alert("모든 필드를 채워주세요.");
                return;
            }

            const startDateTime = formatDateTime(startDate, startTime);
            const endDateTime = formatDateTime(endDate, endTime);

            const scheduleData = {
                scheduleTitle: title,
                scheduleStartDatetime: startDateTime,
                scheduleEndDatetime: endDateTime,
                scheduleDescription: description
            };

            $.ajax({
                url: '/api/calendar/saveUserSchedule',
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(scheduleData),
                success: function(response) {
                    alert("일정이 성공적으로 추가되었습니다.");
                    calendar.addEvent({
                        title: title,
                        start: startDateTime,
                        end: endDateTime,
                        description: description
                    });
                    $('#scheduleAddModal').modal('hide');
                },
                error: function(error) {
                    console.error("AJAX Error:", error);
                    alert("일정 추가 중 오류가 발생했습니다.");
                }
            });
        });
    });
</script>
