<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap');

    .srd-wrapper {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: #f8f9fa;
        color: #333;
        line-height: 1.6;
        padding: 2rem;
    }

    .srd-container {
        max-width: 1000px;
        margin: 0 auto;
        background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
        border-radius: 20px;
        overflow: hidden;
        box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
    }

    .srd-header {
        background: linear-gradient(60deg, #2c786c 0%, #37a794 100%);
        padding: 2rem;
        color: #fff;
        text-align: center;
        position: relative;
    }

    .srd-header::after {
        content: '';
        position: absolute;
        bottom: -50px;
        left: 0;
        right: 0;
        height: 50px;
        background: inherit;
        transform: skewY(-4deg);
    }

    .srd-title {
        font-size: 2.5rem;
        font-weight: 700;
        margin: 0;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
    }

    .srd-content {
        display: flex;
        flex-wrap: wrap;
        padding: 3rem 2rem;
        position: relative;
        z-index: 1;
    }

    .srd-profile {
        flex: 1;
        min-width: 250px;
        text-align: center;
    }

    .srd-profile-image {
        width: 200px;
        height: 200px;
        border-radius: 50%;
        object-fit: cover;
        border: 5px solid #fff;
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        transition: all 0.3s ease;
    }

    .srd-profile-image:hover {
        transform: scale(1.05) rotate(3deg);
        box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
    }

    .srd-info {
        flex: 2;
        min-width: 300px;
    }

    .srd-name {
        font-size: 2.2rem;
        color: #2c786c;
        margin-bottom: 1rem;
        display: flex;
        align-items: center;
        gap: 1rem;
    }

    .srd-gender {
        font-size: 0.9rem;
        background-color: #37a794;
        color: #fff;
        padding: 0.25rem 1rem;
        border-radius: 20px;
        text-transform: uppercase;
    }

    .srd-details {
        display: grid;
        gap: 1.5rem;
    }

    .srd-detail-item {
        background-color: rgba(255, 255, 255, 0.8);
        border-radius: 10px;
        padding: 1.2rem;
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
    }

    .srd-detail-item::before {
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

    .srd-detail-item:hover {
        transform: translateY(-5px);
    }

    .srd-detail-item:hover::before {
        opacity: 1;
    }

    .srd-detail-label {
        font-weight: 600;
        color: #2c786c;
        margin-bottom: 0.5rem;
        display: block;
    }

    .srd-detail-value {
        color: #333;
    }

    .srd-buttons {
        display: flex;
        justify-content: center;
        gap: 1.5rem;
        padding: 40px;
    }

    .srd-btn {
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

    .srd-btn::before {
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

    .srd-btn:hover::before {
        left: 100%;
    }

    .srd-btn-primary {
        background-color: #2c786c;
        color: #fff;
    }

    .srd-btn-primary:hover {
        background-color: #37a794;
        box-shadow: 0 5px 15px rgba(44, 120, 108, 0.4);
    }

    .srd-btn-secondary {
        background-color: #e0f2f1;
        color: #2c786c;
    }

    .srd-btn-secondary:hover {
        background-color: #b2dfdb;
        box-shadow: 0 5px 15px rgba(55, 167, 148, 0.3);
    }

    .srd-health-info {
        margin-top: 0.5rem;
    }

    .srd-health-item {
        background-color: rgba(255, 255, 255, 0.6);
        border-radius: 8px;
        padding: 0.8rem;
        margin-bottom: 0.5rem;
    }

    .srd-health-item:last-child {
        margin-bottom: 0;
    }

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
</style>
<div class="srd-wrapper">
    <div class="srd-container">
        <header class="srd-header">
            <h1 class="srd-title">시니어 상세 정보</h1>
        </header>

        <div class="srd-content">
            <div class="srd-profile">
                <c:choose>
                    <c:when test="${not empty senior.seniorProfile}">
                        <img src="/imgs/senior/${senior.seniorProfile}" class="srd-profile-image" alt="${senior.seniorName}">
                    </c:when>
                    <c:otherwise>
                        <img src="/static/images/default-profile.png" class="srd-profile-image" alt="Default Profile">
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="srd-info">
                <div class="srd-name">
                    ${senior.seniorName}
                    <span class="srd-gender">
            <c:choose>
                <c:when test="${senior.seniorGender == 'M'}">남성</c:when>
                <c:otherwise>여성</c:otherwise>
            </c:choose>
          </span>
                </div>

                <div class="srd-details">
                    <div class="srd-detail-item">
                        <span class="srd-detail-label">생년월일</span>
                        <span class="srd-detail-value">${senior.seniorBirth}</span>
                    </div>

                    <div class="srd-detail-item">
                        <span class="srd-detail-label">전화번호</span>
                        <span class="srd-detail-value">${senior.seniorTel}</span>
                    </div>

                    <div class="srd-detail-item">
                        <span class="srd-detail-label">주소</span>
                        <span class="srd-detail-value">
              ${senior.seniorStreetAddr} ${senior.seniorDetailAddr2}
              <c:if test="${not empty senior.seniorDetailAddr1}">, ${senior.seniorDetailAddr1}</c:if>
              (${senior.seniorZipcode})
            </span>
                    </div>

                    <div class="srd-detail-item">
                        <span class="srd-detail-label">중요 사항</span>
                        <span class="srd-detail-value">${senior.seniorSignificant != null ? senior.seniorSignificant : '특이사항 없음'}</span>
                    </div>

                    <div class="srd-detail-item">
                        <span class="srd-detail-label">등록일</span>
                        <span class="srd-detail-value">${senior.seniorRdate}</span>
                    </div>

                    <div class="srd-detail-item">
                        <span class="srd-detail-label">건강 정보</span>
                        <div class="srd-health-info">
                            <c:choose>
                                <c:when test="${not empty healthinfo}">
                                    <c:forEach items="${healthinfo}" var="info">
                                        <div class="srd-health-item">
                                            <span class="srd-detail-label">질병명</span>
                                            <span class="srd-detail-value">${info.diseaseName}</span>
                                            <span class="srd-detail-label" style="margin-top: 0.5rem;">설명</span>
                                            <span class="srd-detail-value">${info.diseaseDescription}</span>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <span class="srd-detail-value">등록된 건강 정보가 없습니다.</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 차트 영역 -->
        <div class="container mt-5">
            <div class="row justify-content-center mb-4">
                <div class="col-md-3">
                    <div class="card text-center">
                        <div class="card-body">
                            <h5 class="card-title">수축기 혈압</h5>
                            <h2 id="systolicBP">--</h2>
                            <div class="progress mt-3">
                                <div id="progress1" class="progress-bar bg-info" role="progressbar"
                                     style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100">
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
                                     style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
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
                                     style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
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
                                     style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="srd-buttons">
            <a href="/senior/update/${senior.seniorId}" class="srd-btn srd-btn-primary">수정</a>
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
