<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap');

    :root {
        --primary: #5a67d8;
        --primary-dark: #4c51bf;
        --background: #f7fafc;
        --text: #2d3748;
        --text-light: #718096;
        --border: #e2e8f0;
        --white: #ffffff;
        --shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    body {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: var(--background);
        color: var(--text);
        line-height: 1.6;
    }

    .container {
        max-width: 1200px;
        margin: 2rem auto;
        padding: 0 1rem;
    }

    .section {
        background: var(--white);
        border-radius: 15px;
        box-shadow: var(--shadow);
        margin-bottom: 2rem;
        overflow: hidden;
        transition: transform 0.3s ease;
    }

    .section:hover {
        transform: translateY(-5px);
    }

    .section-header {
        background: linear-gradient(135deg, var(--primary) 0%, #7f9cf5 100%);
        color: var(--white);
        padding: 1.5rem 2rem;
        font-size: 1.5rem;
        font-weight: 700;
    }

    .section-content {
        padding: 2rem;
    }

    .map-container {
        height: 400px;
        border-radius: 10px;
        overflow: hidden;
        margin-bottom: 2rem;
        box-shadow: var(--shadow);
    }

    #map {
        width: 100%;
        height: 100%;
    }

    .profile-section {
        display: flex;
        align-items: center;
        gap: 2rem;
        margin-bottom: 2rem;
        background-color: #ebf4ff;
        padding: 1.5rem;
        border-radius: 10px;
    }

    .profile-image {
        width: 270px;
        height: 270px;
        border-radius: 50%;
        object-fit: cover;
        border: 4px solid var(--primary);
        box-shadow: var(--shadow);
    }

    .profile-info h3 {
        color: var(--primary);
        margin: 0 0 1rem;
        font-size: 1.8rem;
    }

    .info-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 1rem;
    }

    .info-item {
        background: var(--white);
        padding: 1rem;
        border-radius: 8px;
        box-shadow: var(--shadow);
        transition: transform 0.3s ease;
    }

    .info-item:hover {
        transform: translateY(-3px);
    }

    .info-label {
        font-size: 0.875rem;
        color: var(--text-light);
        margin-bottom: 0.25rem;
        text-transform: uppercase;
    }

    .info-value {
        font-weight: 600;
        color: var(--text);
    }

    .form-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 1.5rem;
        margin-bottom: 2rem;
    }

    .form-group {
        display: flex;
        flex-direction: column;
        gap: 0.5rem;
    }

    .form-label {
        font-size: 1rem;
        font-weight: 600;
        color: var(--text);
    }

    .form-control {
        width: 100%;
        padding: 0.75rem;
        border: 2px solid var(--border);
        border-radius: 8px;
        font-size: 1rem;
        transition: all 0.3s ease;
    }

    .form-control:focus {
        outline: none;
        border-color: var(--primary);
        box-shadow: 0 0 0 3px rgba(90, 103, 216, 0.2);
    }

    .btn {
        padding: 0.75rem 1.5rem;
        border: none;
        border-radius: 8px;
        font-size: 1rem;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        text-transform: uppercase;
    }

    .btn-success {
        background-color: var(--primary);
        color: var(--white);
    }

    .btn-success:hover {
        background-color: var(--primary-dark);
        transform: translateY(-2px);
        box-shadow: var(--shadow);
    }

    .btn-secondary {
        background-color: var(--text-light);
        color: var(--white);
    }

    .btn-secondary:hover {
        background-color: var(--text);
        transform: translateY(-2px);
        box-shadow: var(--shadow);
    }

    @media (max-width: 768px) {
        .profile-section {
            flex-direction: column;
            text-align: center;
        }

        .form-grid {
            grid-template-columns: 1fr;
        }
    }

    .health-charts {
        display: flex;
        flex-direction: column;
        gap: 1rem;
        width: 100%;
        margin-bottom: 20px;
    }

    .health-chart-title {
        font-size: 1.5rem;
        color: #2c786c;
        margin-bottom: 1rem;
        text-align: center;
    }

    .health-chart-card {
        background-color: #ffffff;
        border-radius: 10px;
        padding: 1rem;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        transition: all 0.3s ease;
    }

    .health-chart-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
    }
    .health-chart-card h5 {
        font-size: 1rem;
        margin-bottom: 0.5rem;
        color: #2c786c;
    }

    .health-chart-card h2 {
        font-size: 2rem;
        margin-bottom: 1rem;
        color: #333;
    }

    .health-chart-card .progress {
        height: 10px;
        background-color: #e0e0e0;
        border-radius: 5px;
        overflow: hidden;
    }

    .health-chart-card .progress-bar {
        height: 100%;
        background-color: #2c786c;
        transition: width 0.5s ease-in-out;
    }
</style>

<div class="container">
    <div class="section">
        <div class="section-header">
            ${contractDetails.user.userName} 고객님
        </div>
        <div class="section-content">
            <div class="map-container">
                <div id="map"
                     data-cw-lat="${contractDetails.careworker.cwLatitude}"
                     data-cw-lng="${contractDetails.careworker.cwLongitude}"
                     data-sr-lat="${contractDetails.senior.seniorLatitude}"
                     data-sr-lng="${contractDetails.senior.seniorLongitude}">
                </div>
            </div>

            <div class="profile-section">
                <img src="/imgs/senior/${contractDetails.senior.seniorProfile}"
                     alt="${contractDetails.senior.seniorName} 어르신 프로필"
                     class="profile-image">
                <div class="profile-info">
                    <h3>${contractDetails.senior.seniorName} 어르신</h3>
                    <div class="info-item">
                        <div class="info-label">성별</div>
                        <div class="info-value"><c:if
                                test="${contractDetails.senior.seniorGender == 'M'}">남자</c:if><c:if
                                test="${contractDetails.senior.seniorGender == 'F'}">여자</c:if></div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">전화번호</div>
                        <div class="info-value">${contractDetails.senior.seniorTel}</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">생년월일</div>
                        <div class="info-value">${contractDetails.senior.seniorBirth}</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">주소</div>
                        <div class="info-value">${contractDetails.senior.seniorStreetAddr}, ${contractDetails.senior.seniorDetailAddr1}, ${contractDetails.senior.seniorDetailAddr2}</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">특이사항</div>
                        <div class="info-value">${contractDetails.senior.seniorSignificant}, ${contractDetails.senior.seniorDetailAddr1}, ${contractDetails.senior.seniorDetailAddr2}</div>
                    </div>
                </div>
            </div>

            <!-- 차트 영역 -->
            <div class="health-charts">
                <h2 class="health-chart-title">실시간 건강수치</h2>
                <div class="health-chart-card">
                    <h5>수축기 혈압</h5>
                    <h2 id="systolicBP">--</h2>
                    <div class="progress">
                        <div id="progress1" class="progress-bar" role="progressbar"
                             style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100">
                        </div>
                    </div>
                </div>
                <div class="health-chart-card">
                    <h5>확장기 혈압</h5>
                    <h2 id="diastolicBP">--</h2>
                    <div class="progress">
                        <div id="progress2" class="progress-bar" role="progressbar"
                             style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                    </div>
                </div>
                <div class="health-chart-card">
                    <h5>심박수</h5>
                    <h2 id="heartRate">--</h2>
                    <div class="progress">
                        <div id="progress3" class="progress-bar" role="progressbar"
                             style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                    </div>
                </div>
                <div class="health-chart-card">
                    <h5>체온</h5>
                    <h2 id="temperature">--</h2>
                    <div class="progress">
                        <div id="progress4" class="progress-bar" role="progressbar"
                             style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                    </div>
                </div>
            </div>

            <div style="text-align: center;">
                <a href="/careworker/worklog/saveform?seniorId=${contractDetails.senior.seniorId}"
                   class="btn btn-secondary">업무일지 작성</a>
                <a href="/careworker/seniors" class="btn btn-secondary">목록으로</a>
            </div>
        </div>
    </div>
</div>
<script src="/js/contract_detail.js"></script>

<script>
    const seniorId = '${contractDetails.senior.seniorId}';

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

