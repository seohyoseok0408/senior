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

<!-- 상세 보기 모달 -->
<div class="modal fade" id="scheduleDetailModal" tabindex="-1" aria-labelledby="scheduleDetailModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="scheduleDetailModalLabel">일정 상세</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="modalScheduleForm">
                    <div style="margin-bottom: 10px;">
                        <label for="modalScheduleTitle">제목</label>
                        <input type="text" id="modalScheduleTitle" name="scheduleTitle" class="form-control" readonly>
                    </div>
                    <div style="margin-bottom: 10px;">
                        <label for="modalScheduleStartDate">시작 날짜</label>
                        <input type="date" id="modalScheduleStartDate" name="scheduleStartDate" class="form-control" readonly>
                    </div>
                    <div style="margin-bottom: 10px;">
                        <label for="modalScheduleStartTime">시작 시간</label>
                        <input type="time" id="modalScheduleStartTime" name="scheduleStartTime" class="form-control" readonly>
                    </div>
                    <div style="margin-bottom: 10px;">
                        <label for="modalScheduleEndDate">종료 날짜</label>
                        <input type="date" id="modalScheduleEndDate" name="scheduleEndDate" class="form-control" readonly>
                    </div>
                    <div style="margin-bottom: 10px;">
                        <label for="modalScheduleEndTime">종료 시간</label>
                        <input type="time" id="modalScheduleEndTime" name="scheduleEndTime" class="form-control" readonly>
                    </div>
                    <div style="margin-bottom: 10px;">
                        <label for="modalScheduleDescription">설명</label>
                        <textarea id="modalScheduleDescription" name="scheduleDescription" class="form-control" rows="4" readonly></textarea>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- 일정 추가 모달 -->
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

<!-- Bootstrap CSS & JS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- FullCalendar CSS & JS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar/main.min.css"/>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>

<!-- FullCalendar 초기화 -->
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
            eventClick: function(arg) {
                document.getElementById('modalScheduleTitle').value = arg.event.title;
                document.getElementById('modalScheduleStartDate').value = arg.event.start.toISOString().split('T')[0];
                document.getElementById('modalScheduleStartTime').value = arg.event.start.toTimeString().slice(0, 5);
                document.getElementById('modalScheduleEndDate').value = arg.event.end.toISOString().split('T')[0];
                document.getElementById('modalScheduleEndTime').value = arg.event.end.toTimeString().slice(0, 5);
                document.getElementById('modalScheduleDescription').value = arg.event.extendedProps.description;
                $('#scheduleDetailModal').modal('show');
            },
            editable: true,
            dayMaxEvents: true
        });

        calendar.render();
    });
</script>
