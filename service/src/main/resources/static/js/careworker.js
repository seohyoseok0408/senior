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
                    url: `/api/careworkers/nearby`,
                    method: 'GET',
                    data: {
                        latitude: latitude,
                        longitude: longitude,
                        radius: radius
                    },
                    success: function (data) {
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
                    },
                    error: function (xhr, status, error) {
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
            $("#contract-btn").on("click", () => {
                this.addContract();
            });
        },
        addContract: function () {
            if (confirm("계약을 신청하시겠습니까?")) {
                const data = {
                    cwId: $('#careworkerId').val(),
                    seniorId: $('#seniorId').val()
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
                    alert(resp.data);
                });
            }
        },
    }
};

// 초기화 실행
$(function () {
    index.init();
});
