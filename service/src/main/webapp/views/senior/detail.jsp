<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h2 class="text-center mb-4" style="margin-top: 50px;">시니어 상세 정보</h2>

<div class="container mt-5">
    <!-- 차트 영역 -->
    <div class="row justify-content-center mb-4">
        <div class="col-md-3">
            <div class="card text-center">
                <div class="card-body">
                    <h5 class="card-title">수축기 혈압</h5>
                    <h2 id="systolicBP">--</h2>
                    <div class="progress mt-3">
                        <div id="progress1" class="progress-bar bg-info" role="progressbar"
                             style="width: 50%" aria-valuenow="50" aria-valuemin="0"
                             aria-valuemax="100">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center">
                <div class="card-body">
                    <h5 class="card-title">확장기 혈압</h5>
                    <h2 id="diastolicBP">--</h2>
                    <div class="progress mt-3">
                        <div id="progress2" class="progress-bar bg-info" role="progressbar"
                             style="width: 50%" aria-valuenow="50" aria-valuemin="0"
                             aria-valuemax="100"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center">
                <div class="card-body">
                    <h5 class="card-title">심박수</h5>
                    <h2 id="heartRate">--</h2>
                    <div class="progress mt-3">
                        <div id="progress3" class="progress-bar bg-info" role="progressbar"
                             style="width: 50%" aria-valuenow="50" aria-valuemin="0"
                             aria-valuemax="100">

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center">
                <div class="card-body">
                    <h5 class="card-title">체온</h5>
                    <h2 id="temperature">--</h2>
                    <div class="progress mt-3">
                        <div id="progress4" class="progress-bar bg-info" role="progressbar"
                             style="width: 50%" aria-valuenow="50" aria-valuemin="0"
                             aria-valuemax="100"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <!-- 시니어 상세 정보 -->
    <div class="row justify-content-center mt-5">
        <div class="col-md-8">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title text-center">${senior.seniorName}</h4>
                    <div class="text-center mb-4">
                        <img src="/imgs/senior/${senior.seniorProfile}"
                             alt="시니어 프로필 이미지"
                             style="width: 200px; height: 200px; border-radius: 50%; object-fit: cover;">
                    </div>
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item">
                            <strong>성별:</strong> <c:choose>
                            <c:when test="${senior.seniorGender == 'M'}">남성</c:when>
                            <c:otherwise>여성</c:otherwise>
                        </c:choose>
                        </li>
                        <li class="list-group-item">
                            <strong>전화번호:</strong> ${senior.seniorTel}
                        </li>
                        <li class="list-group-item">
                            <strong>생년월일:</strong> ${senior.seniorBirth}
                        </li>
                        <li class="list-group-item">
                            <strong>주소:</strong>
                            ${senior.seniorStreetAddr} ${senior.seniorDetailAddr2}, ${senior.seniorDetailAddr1}
                            (${senior.seniorZipcode})
                        </li>
                        <li class="list-group-item">
                            <strong>중요 사항:</strong>
                            <p>${senior.seniorSignificant != null ? senior.seniorSignificant : '특이사항 없음'}</p>
                        </li>
                        <li class="list-group-item">
                            <strong>등록일:</strong> ${senior.seniorRdate}
                        </li>
                    </ul>
                    <h5 class="mt-4">건강 정보</h5>
                    <ul class="list-group">
                        <c:forEach items="${healthinfo}" var="info">
                            <li class="list-group-item">
                                <strong>질병명:</strong> ${info.diseaseName}<br>
                                <strong>설명:</strong> ${info.diseaseDescription}
                            </li>
                        </c:forEach>
                        <c:if test="${healthinfo == null || healthinfo.isEmpty()}">
                            <li class="list-group-item text-muted">등록된 건강 정보가 없습니다.</li>
                        </c:if>
                    </ul>
                    <div class="text-center mt-4">
                        <a href="/senior/update/${senior.seniorId}" class="btn btn-warning">수정</a>
                        <a href="/user/seniors" class="btn btn-secondary">목록으로</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    const seniorId = '${senior.seniorId}'; // JSP에서 전달된 seniorId 사용

    function fetchDataAndUpdateCharts() {
        const url = '/iot/health/data/' + seniorId;

        $.ajax({
            url: url,
            method: 'GET',
            dataType: 'json',
            success: function (response) {
                if (!response || response.length === 0) {
                    console.warn("No data available for seniorId:", seniorId);
                    return;
                }

                // 최신 로그 데이터를 기반으로 업데이트
                const latestData = response[response.length - 1];
                if (latestData) {
                    // 텍스트 직접 업데이트 (직접 ID로 접근)
                    let p1 = latestData.systolicBP;
                    let p2 = latestData.diastolicBP;
                    let p3 = latestData.heartRate;
                    let p4 = latestData.temperature;
                    document.getElementById("systolicBP").innerText = p1;
                    document.getElementById("diastolicBP").innerText = p2;
                    document.getElementById("heartRate").innerText = p3;
                    document.getElementById("temperature").innerText = p4;

                    $('#progress1').css('width', JSON.parse(p1) / 200 * 100 + '%');
                    $('#progress1').attr('aria-valuenow', JSON.parse(p1) / 200 * 100);
                    $('#progress2').css('width', JSON.parse(p2) / 120 * 100 + '%');
                    $('#progress2').attr('aria-valuenow', JSON.parse(p2) / 120 * 100);
                    $('#progress3').css('width', JSON.parse(p3) / 120 * 100 + '%');
                    $('#progress3').attr('aria-valuenow', JSON.parse(p3) / 120 * 100);
                    $('#progress4').css('width', JSON.parse(p4) / 45 * 100 + '%');
                    $('#progress4').attr('aria-valuenow', JSON.parse(p4) / 45 * 100);

                }
            },
            error: function (xhr, status, error) {
                console.error(`Error fetching data: Status ${xhr.status}, Error: ${error}`);
            }
        });
    }

    function updateCard(elementId, value, progressBarId, min, max) {
        const element = document.getElementById(elementId);
        const progressBar = document.getElementById(progressBarId);

        // 텍스트 업데이트
        if (element) {
            element.innerText = value;
        }

        // Progress Bar 업데이트
        if (progressBar) {
            const percentage = Math.max(0, Math.min(100, ((value - min) / (max - min)) * 100));
            progressBar.style.width = `${percentage}%`; // Progress Bar 너비 조정
            progressBar.setAttribute("aria-valuenow", percentage); // 접근성 속성 업데이트
        }
    }

    // 주기적으로 데이터를 가져오고 업데이트
    setInterval(fetchDataAndUpdateCharts, 2000);
    fetchDataAndUpdateCharts(); // 초기 호출
</script>


<style>
    .card {
        border: 1px solid #e0e0e0;
        border-radius: 8px;
        padding: 15px;
        background-color: #fff;
    }

    .progress-bar {
        background-color: #28a745;
        height: 20px;
        transition: width 0.5s ease-in-out; /* 애니메이션 추가 */
    }

    .senior-detail {
        margin-top: 30px;
    }
</style>
