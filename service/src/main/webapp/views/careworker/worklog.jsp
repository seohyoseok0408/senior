<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    .worklog-detail-wrapper {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: #f8f9fa;
        padding: 2rem;
    }

    .worklog-detail-container {
        max-width: 800px;
        margin: 0 auto;
        background: white;
        border-radius: 15px;
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        overflow: hidden;
    }

    .worklog-header {
        background: #2c786c;
        color: white;
        text-align: center;
        padding: 1.5rem;
        font-size: 1.5rem;
        font-weight: 700;
    }

    .worklog-content {
        padding: 2rem;
    }

    .worklog-item {
        margin-bottom: 1.5rem;
        padding-bottom: 1rem;
        border-bottom: 1px solid #e9ecef;
    }

    .worklog-label {
        font-weight: 600;
        color: #2c786c;
        margin-bottom: 0.5rem;
    }

    .worklog-value {
        color: #333;
        font-size: 1.1rem;
    }

    .worklog-buttons {
        text-align: center;
        margin-top: 2rem;
    }

    .btn {
        display: inline-block;
        padding: 0.75rem 1.5rem;
        font-size: 1rem;
        font-weight: 500;
        color: white;
        background-color: #2c786c;
        border-radius: 25px;
        text-decoration: none;
        transition: all 0.3s ease;
        margin-right: 1rem;
    }

    .btn:hover {
        background-color: #37a794;
        box-shadow: 0 5px 15px rgba(44, 120, 108, 0.4);
    }

    .btn-secondary {
        background-color: #e0f2f1;
        color: #2c786c;
        margin: 10px;
    }

    .btn-secondary:hover {
        background-color: #b2dfdb;
        box-shadow: 0 5px 15px rgba(55, 167, 148, 0.3);
    }
</style>

<div class="worklog-detail-wrapper">
    <div class="worklog-detail-container">
        <!-- 업무일지 제목 -->
        <div class="worklog-header">
            업무일지 상세보기
        </div>

        <!-- 업무일지 콘텐츠 -->
        <div class="worklog-content">
            <div class="worklog-item">
                <span class="worklog-label">작성일</span>
                <span class="worklog-value">
                    <fmt:parseDate value="${workLog.workLogRdate}" pattern="yyyy-MM-dd'T'HH:mm" var="rdate" type="both"/>
                    <fmt:formatDate pattern="yyyy년 MM월 dd일 HH시 mm분" value="${ rdate }"/>
                </span>
            </div>
            <div class="worklog-item">
                <span class="worklog-label">방문 시작 시간</span>
                <span class="worklog-value">
                    <fmt:parseDate value="${workLog.visitStartTime}" pattern="yyyy-MM-dd'T'HH:mm" var="start" type="both"/>
                    <fmt:formatDate pattern="yyyy년 MM월 dd일 HH시 mm분" value="${ start }"/>
                </span>
            </div>
            <div class="worklog-item">
                <span class="worklog-label">방문 종료 시간</span>
                <span class="worklog-value">
                    <fmt:parseDate value="${workLog.visitEndTime}" pattern="yyyy-MM-dd'T'HH:mm" var="end" type="both"/>
                    <fmt:formatDate pattern="yyyy년 MM월 dd일 HH시 mm분" value="${ end }"/>
                </span>
            </div>
            <div class="worklog-item">
                <span class="worklog-label">업무 내용</span>
                <span class="worklog-value">
                    ${workLog.workLogContent}
                </span>
            </div>
            <div class="worklog-item">
                <span class="worklog-label">담당자 :</span>
                <span class="worklog-value">${careworker.cwName}</span>
            </div>
        </div>

        <div class="worklog-buttons">
            <a href="/careworker/seniors" class="btn btn-secondary">목록으로</a>
        </div>
    </div>
</div>
