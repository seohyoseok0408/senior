let index = {
    init: function () {
        this.careworkerList.init();
        this.careworkerDetail.init();
    },

    careworkerList: {
        init: function () {
            const fetchCareworkers = () => {
                const senior = $('#senior-info').val().split(',');
                const seniorId = senior[0];
                const latitude = senior[1];
                const longitude = senior[2];
                const radius = $('#radius-select').val();

                $.ajax({
                    url: `/api/careworkers/nearby`, method: 'GET', data: {
                        latitude: latitude, longitude: longitude, radius: radius
                    }, success: function (data) {
                        if (!Array.isArray(data)) {
                            alert("API 응답이 올바르지 않습니다.");
                            return;
                        }

                        const listDiv = $('#careworker-list');
                        listDiv.empty();

                        data.forEach(careworker => {
                            const name = careworker.cwName || '이름 없음';
                            const profile = careworker.cwProfile || 'default-profile.png';
                            const tel = careworker.cwTel || '연락처 없음';
                            const distance = careworker.distance != null ? careworker.distance.toFixed(2) + ' km' : '정보 없음';

                            const card = `
                            <div class="card">
                                <img src="/imgs/careworker/${profile}" class="card-img-top" alt="${name}" onerror="this.src='/imgs/default-profile.jpg'">
                                <div class="card-body">
                                    <h5 class="card-title">${name}</h5>
                                    <p class="card-text">
                                        <strong>거리:</strong> ${distance}<br>
                                        <strong>연락처:</strong> ${tel}
                                    </p>
                                    <a href="/user/careworkers/detail?cwId=${careworker.cwId}&seniorId=${seniorId}" class="btn btn-primary btn-sm">자세히 보기</a>
                                </div>
                            </div>
                        `;
                            listDiv.append(card);
                        });
                    }, error: function (xhr, status, error) {
                        console.error("Error:", error);
                        alert("보호사 데이터를 가져오는 데 실패했습니다.");
                    }
                });
            };

            $(document).ready(fetchCareworkers);
            $('#search-btn').click(fetchCareworkers);
        }
    },

    careworkerDetail: {
        init: function () {
            this.initializeCalendar();
            $("#contract-btn").on("click", () => {
                this.addContract();
            });
        }, initializeCalendar: function () {
            const calendarEl = document.getElementById('calendar');

            const calendar = new FullCalendar.Calendar(calendarEl, {
                headerToolbar: {
                    left: 'prev,next today', center: 'title', right: 'dayGridMonth,timeGridWeek,timeGridDay'
                }, timeZone: 'local', // 또는 'local'을 명시적으로 지정
                selectable: true, selectMirror: true, select: function (info) {
                    // 시작 날짜와 시간
                    const startDate = info.start.toISOString().split('T')[0];
                    const startTime = '12:00'; // 기본 시간 설정

                    // 종료 날짜와 시간
                    const endDate = new Date(info.end);
                    endDate.setDate(endDate.getDate() - 1); // 하루 빼기
                    const formattedEndDate = endDate.toISOString().split('T')[0];
                    const endTime = '12:00'; // 기본 시간 설정

                    // 폼에 값 입력
                    document.getElementById('contractStartDate').value = startDate;
                    document.getElementById('contractStartTime').value = startTime;
                    document.getElementById('contractEndDate').value = formattedEndDate;
                    document.getElementById('contractEndTime').value = endTime;

                    // 알림 표시
                    alert(`선택한 일정: ${startDate} ${startTime} ~ ${formattedEndDate} ${endTime}`);
                }, editable: true, dayMaxEvents: true
            });

            calendar.render();
        }, addContract: function () {
            if (confirm("계약을 신청하시겠습니까?")) {
                // 시작 날짜와 시간 결합
                const startDate = $('#contractStartDate').val();
                const startTime = $('#contractStartTime').val();
                const startDateTime = startDate + "T" + startTime + ":00";

                // 종료 날짜와 시간 결합
                const endDate = $('#contractEndDate').val();
                const endTime = $('#contractEndTime').val();
                const endDateTime = endDate + "T" + endTime + ":00";

                const data = {
                    cwId: $('#careworkerId').val(),
                    seniorId: $('#seniorId').val(),
                    contractStartDatetime: startDateTime,
                    contractEndDatetime: endDateTime
                };

                $.ajax({
                    url: `/api/contract`,
                    method: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(data),
                    dataType: 'json'
                }).done(function (resp) {
                    console.log("응답 성공:", resp);
                    if (resp.status === 200) {
                        alert(resp.data);
                        location.href = '/';
                    } else {
                        alert("신청이 실패하였습니다: " + resp.data);
                    }
                }).fail(function (xhr, status, error) {
                    console.error("응답 실패:", error);
                    alert("계약 신청 중 오류가 발생했습니다.");
                });
            }
        },
    }
};

// 초기화 실행
$(function () {
    index.init();
});
