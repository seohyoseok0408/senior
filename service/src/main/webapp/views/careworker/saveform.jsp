<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="worklog-container">
  <div class="sidebar">
    <h1 class="worklog-title">${senior.seniorName}님의<br>업무일지</h1>
    <div class="time-inputs">
      <div class="form-group">
        <label for="visitStartDate" class="form-label">근무 시작</label>
        <input type="datetime-local" id="visitStartDate" class="form-input">
      </div>
      <div class="form-group">
        <label for="visitEndDate" class="form-label">근무 종료</label>
        <input type="datetime-local" id="visitEndDate" class="form-input">
      </div>
    </div>
    <button id="btn-save" class="btn-submit">
      <span class="btn-text">업무일지 제출</span>
      <span class="btn-icon">↗</span>
    </button>
  </div>

  <div class="content-area">
    <div class="content-header">
      <h2 class="content-title">오늘의 업무 내용</h2>
      <div class="content-date" id="currentDate"></div>
    </div>
    <textarea id="content" class="summernote"></textarea>
  </div>
</div>

<input type="hidden" id="cwId" value="${sessionScope.principal}">
<input type="hidden" id="seniorId" value="${senior.seniorId}">

<style>
  body {
    margin: 0;
    padding: 0;
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f0f4f8;
  }

  .worklog-container {
    display: flex;
    height: 100vh;
  }

  .sidebar {
    width: 300px;
    background: linear-gradient(135deg, #34d399 0%, #059669 100%);
    color: white;
    padding: 40px;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    box-shadow: 4px 0 10px rgba(0, 0, 0, 0.1);
  }

  .worklog-title {
    font-size: 28px;
    font-weight: 700;
    margin-bottom: 40px;
    line-height: 1.3;
    text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1);
  }

  .time-inputs {
    margin-bottom: 40px;
  }

  .form-group {
    margin-bottom: 20px;
  }

  .form-label {
    display: block;
    font-size: 14px;
    margin-bottom: 8px;
    opacity: 0.8;
  }

  .form-input {
    width: 100%;
    padding: 10px;
    font-size: 14px;
    background-color: rgba(255, 255, 255, 0.1);
    border: none;
    border-radius: 5px;
    color: white;
  }

  .form-input:focus {
    outline: none;
    background-color: rgba(255, 255, 255, 0.2);
  }

  .btn-submit {
    background-color: white;
    color: #40c057;
    border: none;
    padding: 15px;
    font-size: 16px;
    font-weight: 600;
    border-radius: 5px;
    cursor: pointer;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    justify-content: space-between;
  }

  .btn-submit:hover {
    background-color: #f0f0f0;
    transform: translateY(-2px);
  }

  .btn-icon {
    font-size: 20px;
  }

  .content-area {
    flex: 1;
    padding: 40px;
    display: flex;
    flex-direction: column;
  }

  .content-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
  }

  .content-title {
    font-size: 24px;
    font-weight: 600;
    color: #333;
  }

  .content-date {
    font-size: 14px;
    color: #666;
  }

  .summernote {
    flex: 1;
  }

  .note-editor {
    display: flex;
    flex-direction: column;
    height: 100%;
    border: none !important;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  }

  .note-editing-area {
    flex: 1;
  }

  .note-editable {
    height: 100% !important;
  }

  .note-toolbar {
    background-color: #f8f9fa;
    border-bottom: 1px solid #e0e0e0;
  }

  .note-btn {
    background-color: transparent;
    border: none;
    color: #555;
    transition: all 0.2s ease;
  }

  .note-btn:hover {
    background-color: #e9ecef;
    color: #40c057;
  }

  @media (max-width: 768px) {
    .worklog-container {
      flex-direction: column;
    }

    .sidebar {
      width: 100%;
      padding: 20px;
    }

    .content-area {
      padding: 20px;
    }
  }
</style>

<script src="/js/board.js"></script>
