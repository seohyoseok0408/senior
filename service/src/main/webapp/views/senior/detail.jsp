<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap');

    .tabs {
        display: flex;
        justify-content: center;
        margin-bottom: 1rem;
        background: #e0f7fa;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
    }

    .tab {
        flex: 1;
        text-align: center;
        padding: 1rem;
        font-weight: 600;
        color: #555;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    .tab.active {
        background: #2c786c;
        color: white;
    }

    .tab:hover {
        background: #b2dfdb;
    }

    .tab-content {
        display: none;
    }

    .tab-content.active {
        display: block;
    }

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

    .srd-content {
        display: flex;
        flex-wrap: wrap;
        padding: 3rem 2rem;
        position: relative;
        z-index: 1;
        gap: 2rem;
    }

    .srd-profile, .srd-info {
        flex: 1;
        min-width: 300px;
        max-width: calc(50% - 1rem);
    }

    .srd-profile {
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    .srd-profile-image {
        width: 200px;
        height: 200px;
        border-radius: 50%;
        object-fit: cover;
        border: 5px solid #fff;
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        transition: all 0.3s ease;
        margin-bottom: 2rem;
    }

    .srd-profile-image:hover {
        transform: scale(1.05) rotate(3deg);
        box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
    }

    .srd-info {
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
        gap: 1.9rem;
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

    .health-charts {
        display: flex;
        flex-direction: column;
        gap: 1rem;
        width: 100%;
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


    .contracts-list {
        background: white;
        border-radius: 15px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .contract-item {
        display: flex;
        align-items: center;
        padding: 1.5rem;
        border-bottom: 1px solid #e9ecef;
        transition: all 0.3s ease;
    }

    .contract-item:last-child {
        border-bottom: none;
    }

    .contract-item:hover {
        background-color: #f8f9fa;
    }

    .contract-main {
        flex: 1;
        display: grid;
        grid-template-columns: 2fr 1fr 2fr 1fr;
        gap: 2rem;
        align-items: center;
    }

    .customer-info {
        display: flex;
        flex-direction: column;
    }

    .title-name {
        font-size: 1.1rem;
        font-weight: 600;
        color: #40c057;
        margin-bottom: 0.25rem;
    }

    .action-btn {
        background-color: #40c057;
        color: white;
        border: none;
        border-radius: 25px;
        padding: 0.5rem 1.5rem;
        font-weight: 500;
        text-decoration: none;
        transition: all 0.2s ease;
    }

    .action-btn:hover {
        background-color: #2b8a3e;
        transform: translateY(-2px);
    }

    @media (max-width: 768px) {
        .contract-main {
            grid-template-columns: 1fr;
            gap: 1rem;
        }

        .contract-item {
            flex-direction: column;
            align-items: flex-start;
        }

        .action-btn {
            margin-top: 1rem;
            width: 100%;
            text-align: center;
        }
    }
</style>

<div class="srd-wrapper">
    <div class="srd-container">
        <div class="tabs">
            <div class="tab active" id="tab-info">시니어 상세정보</div>
            <div class="tab" id="tab-worklog">업무일지</div>
        </div>
        <div class="tab-content active" id="content-info">
            <div class="srd-content">
                <div class="srd-profile">
                    <c:choose>
                        <c:when test="${not empty senior.seniorProfile}">
                            <img src="/imgs/senior/${senior.seniorProfile}" class="srd-profile-image"
                                 alt="${senior.seniorName}">
                        </c:when>
                        <c:otherwise>
                            <img src="/static/images/default-profile.png" class="srd-profile-image"
                                 alt="Default Profile">
                        </c:otherwise>
                    </c:choose>

                    <!-- 차트 영역 -->
                    <div class="health-charts">
                        <h2 class="health-chart-title">건강 정보</h2>
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

            <div class="srd-buttons">
                <a href="/senior/update/${senior.seniorId}" class="srd-btn srd-btn-primary">수정</a>
            </div>
        </div>
        <div class="tab-content" id="content-worklog">
            <div class="contracts-list">
                <c:forEach var="worklog" items="${workLogs}">
                    <div class="contract-item">
                        <div class="contract-main">
                            <div class="customer-info">
                                <span class="title-name">
                                    <fmt:parseDate value="${worklog.workLogRdate}"
                                                   pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime" type="both" />
                                    <fmt:formatDate pattern="yyyy년 MM월 dd일 HH시 mm분" value="${ parsedDateTime }" />
                                </span>
                            </div>
                            <div class="status-info">

                            </div>
                        </div>
                        <a href="/user/worklog?workLogId=${worklog.workLogId}" class="action-btn">
                            자세히 보기
                        </a>
                    </div>
                </c:forEach>
            </div>

        </div>

    </div>
</div>

<script>
    const seniorId = '${senior.seniorId}';

    let index = {
        init: function () {
            // 주기적으로 데이터를 가져오고 업데이트
            this.fetchDataAndUpdateCharts(); // 초기 호출
            setInterval(this.fetchDataAndUpdateCharts, 2000);
            $("#tab-info").click(function () {
                $(".tab").removeClass("active");
                $(this).addClass("active");
                $(".tab-content").removeClass("active");
                $("#content-info").addClass("active");
            });
            $("#tab-worklog").click(function () {
                $(".tab").removeClass("active");
                $(this).addClass("active");
                $(".tab-content").removeClass("active");
                $("#content-worklog").addClass("active");
            });

        },
        fetchDataAndUpdateCharts: function () {
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
        },
        updateCard: function (elementId, value, progressBarId, min, max) {
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
    }
    index.init();
</script>

