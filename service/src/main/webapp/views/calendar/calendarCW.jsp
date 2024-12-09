<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    .fc-event-title {
        font-weight: bold !important; /* 텍스트 두껍게 */
        font-size: 14px; /* 글자 크기 조정 */
    }
</style>

<div class="content-body">
    <div class="container-fluid">
        <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-top: 20px;">
            <div id="calendar" style="flex: 0 0 70%; border: 1px solid #ddd; padding: 10px;"></div>

            <div id="scheduleDetails" style="flex: 0 0 25%; padding: 20px; border-radius: 8px; border: 1px solid #ddd; margin-left: 20px; background-color: #f9f9f9; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
                <h5 style="margin-bottom: 15px; font-size: 18px; font-weight: bold; color: #333; border-bottom: 2px solid #ddd; padding-bottom: 10px;">📅 일정 상세정보</h5>
                <div style="margin-bottom: 15px;">
                    <span style="display: block; font-size: 14px; color: #888; font-weight: bold; margin-bottom: 5px;">제목</span>
                    <span id="scheduleTitle" style="font-size: 16px; color: #555;">-</span>
                </div>
                <div style="margin-bottom: 15px;">
                    <span style="display: block; font-size: 14px; color: #888; font-weight: bold; margin-bottom: 5px;">설명</span>
                    <span id="scheduleDescription" style="font-size: 16px; color: #555;">-</span>
                </div>
                <div style="margin-bottom: 15px;">
                    <span style="display: block; font-size: 14px; color: #888; font-weight: bold; margin-bottom: 5px;">시작</span>
                    <span id="scheduleStartDatetime" style="font-size: 16px; color: #555;">-</span>
                </div>
                <div style="margin-bottom: 15px;">
                    <span style="display: block; font-size: 14px; color: #888; font-weight: bold; margin-bottom: 5px;">종료</span>
                    <span id="scheduleEndDatetime" style="font-size: 16px; color: #555;">-</span>
                </div>
            </div>
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
                        <label for="modalAddEndDate">종료 날짜</label>
                        <input type="date" id="modalAddEndDate" name="scheduleEndDate" class="form-control" readonly>
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

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar/main.min.css"/>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>

<script>
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
            events: eventsData
                .filter(event => event.scheduleStatus !== 'CANCELLED') // CANCELLED 상태 제외
                .map(event => {
                    const isAllDay = true; // 모든 이벤트를 '종일'로 설정

                    // 시작/종료 날짜만 추출
                    const startDate = event.scheduleStartDatetime.split('T')[0];
                    const endDate = event.scheduleEndDatetime.split('T')[0];

                    return {
                        title: event.scheduleTitle,
                        start: startDate, // 날짜만 설정
                        end: endDate, // 날짜만 설정
                        description: event.scheduleDescription,
                        allDay: isAllDay,
                        color: event.scheduleStatus === 'WAITING' ? '#ffa726' : '#c0e0a3',
                        textColor: '#000000',
                        extendedProps: {
                            status: event.scheduleStatus
                        }
                    };
                }),
            select: function(arg) {
                const adjustedEndDate = new Date(arg.end);
                adjustedEndDate.setDate(adjustedEndDate.getDate());

                document.getElementById('modalAddStartDate').value = arg.startStr;
                document.getElementById('modalAddEndDate').value = adjustedEndDate.toISOString().slice(0, 10);
                $('#scheduleAddModal').modal('show');
            },
            eventClick: function(info) {
                console.log("Clicked event:", info.event);
                console.log("Extended props:", info.event.extendedProps);

                document.getElementById('scheduleTitle').textContent = (info.event.title || '-');
                document.getElementById('scheduleDescription').textContent =(info.event.extendedProps.description || '-');
                document.getElementById('scheduleStartDatetime').textContent =
                    (info.event.start ? info.event.start.toLocaleDateString('ko-KR') : '-'); // 로컬 날짜만 표시
                document.getElementById('scheduleEndDatetime').textContent =
                    (info.event.end ? info.event.end.toLocaleDateString('ko-KR') : '-'); // 로컬 날짜만 표시
            },
            editable: true,
            dayMaxEvents: true
        });

        calendar.render();

        document.getElementById('saveScheduleBtn').addEventListener('click', function () {
            var title = document.getElementById('addScheduleTitle').value.trim();
            var startDate = document.getElementById('modalAddStartDate').value;
            var endDate = document.getElementById('modalAddEndDate').value;
            var description = document.getElementById('modalAddDescription').value.trim();

            if (!title || !startDate || !endDate || !description) {
                alert("모든 필드를 채워주세요.");
                return;
            }

            const startDateTime = startDate + "T13:13:00";
            const endDateTime = endDate + "T13:13:00";

            const scheduleData = {
                scheduleTitle: title,
                scheduleStartDatetime: startDateTime,
                scheduleEndDatetime: endDateTime,
                scheduleDescription: description
            };

            $.ajax({
                url: '/api/calendar/saveCareworkerSchedule',
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

