<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap');

    :root {
        --primary: #2ecc71;
        --primary-light: #e8f8f5;
        --secondary: #27ae60;
        --background: #f9f9f9;
        --text: #2c3e50;
        --text-light: #7f8c8d;
        --border: #a5d6a7;
        --white: #ffffff;
        --shadow: 0 4px 6px rgba(46, 204, 113, 0.1);
        --transition: all 0.3s ease;
    }

    body {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: var(--background);
        color: var(--text);
        line-height: 1.6;
        margin: 0;
        padding: 0;
    }

    .container {
        max-width: 1400px;
        margin: 0 auto;
        padding: 2rem;
    }

    .dashboard {
        display: grid;
        grid-template-columns: 1fr 2fr;
        gap: 2rem;
    }

    .card {
        background: var(--white);
        border-radius: 20px;
        box-shadow: var(--shadow);
        overflow: hidden;
        transition: var(--transition);
    }

    .card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 15px rgba(46, 204, 113, 0.2);
    }

    .card-header {
        background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
        color: var(--white);
        padding: 1.5rem 2rem;
        font-size: 1.5rem;
        font-weight: 700;
        text-align: center;
    }

    .card-body {
        padding: 2rem;
    }

    .profile-section {
        display: flex;
        flex-direction: column;
        align-items: center;
        text-align: center;
    }

    .profile-image {
        width: 200px;
        height: 200px;
        border-radius: 50%;
        object-fit: cover;
        border: 5px solid var(--primary);
        box-shadow: var(--shadow);
        margin-bottom: 1.5rem;
    }

    .profile-name {
        font-size: 2rem;
        color: var(--primary);
        margin-bottom: 0.5rem;
    }

    .profile-details {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 1rem;
        margin-top: 1.5rem;
    }

    .profile-item {
        background: var(--primary-light);
        padding: 1rem;
        border-radius: 10px;
        transition: var(--transition);
    }

    .profile-item:hover {
        transform: translateY(-3px);
        box-shadow: var(--shadow);
    }

    .profile-label {
        font-size: 0.9rem;
        color: var(--text-light);
        margin-bottom: 0.25rem;
        text-transform: uppercase;
    }

    .profile-value {
        font-weight: 600;
        color: var(--text);
    }

    .map-container {
        height: 300px;
        border-radius: 15px;
        overflow: hidden;
        box-shadow: var(--shadow);
        margin-top: 2rem;
    }

    #map {
        width: 100%;
        height: 100%;
    }

    .health-charts {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 1.5rem;
    }

    .health-chart-card {
        background: var(--white);
        border-radius: 15px;
        padding: 1.5rem;
        text-align: center;
        transition: var(--transition);
    }

    .health-chart-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 15px rgba(46, 204, 113, 0.2);
    }

    .health-chart-icon {
        font-size: 2.5rem;
        color: var(--primary);
        margin-bottom: 1rem;
    }

    .health-chart-title {
        font-size: 1.1rem;
        color: var(--text-light);
        margin-bottom: 0.5rem;
    }

    .health-chart-value {
        font-size: 2.5rem;
        font-weight: 700;
        color: var(--text);
        margin-bottom: 1rem;
    }

    .progress {
        height: 10px;
        background-color: var(--border);
        border-radius: 5px;
        overflow: hidden;
    }

    .progress-bar {
        height: 100%;
        background-color: var(--secondary);
        transition: width 0.5s ease-in-out;
    }

    .btn {
        display: block;
        padding: 15px 20px;
        border: none;
        border-radius: 10px;
        font-size: 1.2rem;
        font-weight: 600;
        cursor: pointer;
        transition: var(--transition);
        text-decoration: none;
        text-align: center;
        width: 100%;
        margin-top: 1rem;
        height: 58px;
    }

    .btn-primary {
        background-color: var(--primary);
        color: var(--white);
    }

    .btn-primary:hover {
        background-color: var(--secondary);
        transform: translateY(-2px);
    }

    .btn-secondary {
        background-color: var(--text-light);
        color: var(--white);
    }

    .btn-secondary:hover {
        background-color: var(--text);
        transform: translateY(-2px);
    }

    @media (max-width: 1200px) {
        .dashboard {
            grid-template-columns: 1fr;
        }
    }

    @media (max-width: 768px) {
        .container {
            padding: 1rem;
        }

        .health-charts {
            grid-template-columns: 1fr;
        }

        .profile-details {
            grid-template-columns: 1fr;
        }
    }
</style>

<div class="container">
    <div class="dashboard">
        <div class="card">
            <div class="card-header">
                프로필 정보
            </div>
            <div class="card-body">
                <div class="profile-section">
                    <img src="/imgs/senior/${contractDetails.senior.seniorProfile}"
                         alt="${contractDetails.senior.seniorName} 어르신 프로필"
                         class="profile-image">
                    <h2 class="profile-name">${contractDetails.senior.seniorName} 어르신</h2>
                    <div class="profile-details">
                        <div class="profile-item">
                            <div class="profile-label">성별</div>
                            <div class="profile-value">
                                <c:choose>
                                    <c:when test="${contractDetails.senior.seniorGender == 'M'}">남자</c:when>
                                    <c:when test="${contractDetails.senior.seniorGender == 'F'}">여자</c:when>
                                    <c:otherwise>-</c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="profile-item">
                            <div class="profile-label">전화번호</div>
                            <div class="profile-value">${contractDetails.senior.seniorTel}</div>
                        </div>
                        <div class="profile-item">
                            <div class="profile-label">생년월일</div>
                            <div class="profile-value">${contractDetails.senior.seniorBirth}</div>
                        </div>
                        <div class="profile-item">
                            <div class="profile-label">주소</div>
                            <div class="profile-value">${contractDetails.senior.seniorStreetAddr}, ${contractDetails.senior.seniorDetailAddr1}, ${contractDetails.senior.seniorDetailAddr2}</div>
                        </div>
                    </div>
                </div>
                <div class="map-container">
                    <div id="map"
                         data-cw-lat="${contractDetails.careworker.cwLatitude}"
                         data-cw-lng="${contractDetails.careworker.cwLongitude}"
                         data-sr-lat="${contractDetails.senior.seniorLatitude}"
                         data-sr-lng="${contractDetails.senior.seniorLongitude}">
                    </div>
                </div>
            </div>
        </div>
        <div class="card">
            <div class="card-header">
                실시간 건강 모니터링
            </div>
            <div class="card-body">
                <div class="health-charts">
                    <div class="health-chart-card">
                        <div class="health-chart-icon">💗</div>
                        <h3 class="health-chart-title">수축기 혈압</h3>
                        <div class="health-chart-value" id="systolicBP">--</div>
                        <div class="progress">
                            <div id="progress1" class="progress-bar" role="progressbar"
                                 style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100">
                            </div>
                        </div>
                    </div>
                    <div class="health-chart-card">
                        <div class="health-chart-icon">💓</div>
                        <h3 class="health-chart-title">확장기 혈압</h3>
                        <div class="health-chart-value" id="diastolicBP">--</div>
                        <div class="progress">
                            <div id="progress2" class="progress-bar" role="progressbar"
                                 style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>
                    <div class="health-chart-card">
                        <div class="health-chart-icon">❤️</div>
                        <h3 class="health-chart-title">심박수</h3>
                        <div class="health-chart-value" id="heartRate">--</div>
                        <div class="progress">
                            <div id="progress3" class="progress-bar" role="progressbar"
                                 style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>
                    <div class="health-chart-card">
                        <div class="health-chart-icon">🌡️</div>
                        <h3 class="health-chart-title">체온</h3>
                        <div class="health-chart-value" id="temperature">--</div>
                        <div class="progress">
                            <div id="progress4" class="progress-bar" role="progressbar"
                                 style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>
                    <a href="/careworker/worklog/saveform?seniorId=${contractDetails.senior.seniorId}"
                               class="btn btn-primary">업무일지 작성</a>
                    <a href="/careworker/seniors" class="btn btn-secondary">목록으로</a>

                </div>
            </div>
        </div>
    </div>
</div>

<script src="/js/contract_detail.js"></script>
<script>
    const seniorId = '${senior.seniorId}';

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
            error: function (xhr,status, error) {
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

