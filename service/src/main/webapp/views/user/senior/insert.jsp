<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    body {
        background-color: #f8f9fa;
        color: #333;
    }

    .signup-container {
        max-width: 800px;
        margin: 0 auto;
        padding: 3rem 2rem;
    }

    .signup-header {
        text-align: center;
        margin-bottom: 3rem;
    }

    .signup-title {
        color: #249d57;
        font-size: 2.5rem;
        font-weight: 700;
        margin-bottom: 1rem;
    }

    .signup-subtitle {
        color: #666;
        font-size: 1.1rem;
    }

    .form-section {
        background: white;
        padding: 2.5rem;
        border-radius: 16px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
        margin-bottom: 2rem;
    }

    .section-title {
        color: #249d57;
        font-size: 1.25rem;
        font-weight: 600;
        margin-bottom: 1.5rem;
        padding-bottom: 0.5rem;
        border-bottom: 2px solid #dff2e1;
    }

    .profile-preview-container {
        text-align: center;
        margin-bottom: 2rem;
    }

    #profilePreview {
        width: 150px;
        height: 150px;
        border-radius: 50%;
        object-fit: cover;
        border: 3px solid #dff2e1;
        padding: 3px;
        cursor: pointer;
        transition: all 0.3s ease;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    #profilePreview:hover {
        border-color: #249d57;
        transform: scale(1.05);
    }

    .form-group {
        margin-bottom: 1.5rem;
    }

    .form-group label {
        display: block;
        color: #333;
        font-weight: 500;
        margin-bottom: 0.5rem;
    }

    .form-control {
        height: 48px;
        border-radius: 8px;
        border: 1px solid #e0e0e0;
        padding: 0.75rem 1rem;
        font-size: 1rem;
        transition: all 0.3s ease;
    }

    .form-control:focus {
        border-color: #249d57;
        box-shadow: 0 0 0 0.2rem rgba(36, 157, 87, 0.25);
    }

    textarea.form-control {
        height: auto;
        min-height: 120px;
        resize: none;
    }

    .form-text {
        font-size: 0.875rem;
        margin-top: 0.5rem;
    }

    .text-success {
        color: #249d57 !important;
    }

    .text-danger {
        color: #dc3545 !important;
    }

    #zipcodeBtn {
        height: 48px;
        background-color: #f8f9fa;
        border: 1px solid #e0e0e0;
        color: #333;
        transition: all 0.3s ease;
        padding: 0 1.5rem;
        border-radius: 8px;
        cursor: pointer;
    }

    #zipcodeBtn:hover {
        background-color: #dff2e1;
        border-color: #249d57;
        color: #249d57;
    }

    #btn_add {
        height: 54px;
        font-size: 1.1rem;
        font-weight: 600;
        background-color: #249d57;
        color: white;
        border: none;
        border-radius: 8px;
        width: 100%;
        margin-top: 2rem;
        transition: all 0.3s ease;
        cursor: pointer;
    }

    #btn_add:hover {
        background-color: #1b7642;
        transform: translateY(-1px);
    }

    .input-group {
        display: flex;
        gap: 0.5rem;
    }
</style>

<div class="signup-container">
    <div class="signup-header">
        <h1 class="signup-title">시니어케어</h1>
        <p class="signup-subtitle">시니어 등록을 환영합니다</p>
    </div>

    <form id="senior_add_form">
        <!-- 프로필 이미지 섹션 -->
        <div class="form-section">
            <h2 class="section-title">프로필 이미지</h2>
            <div class="profile-preview-container">
                <label for="profile">
                    <img id="profilePreview" src="/images/default-profile.jpg" alt="이미지 미리보기"/>
                </label>
                <input type="file" class="form-control" id="profile" name="seniorProfileFile"
                       accept="image/*" hidden="hidden"/>
            </div>
        </div>

        <!-- 기본 정보 섹션 -->
        <div class="form-section">
            <h2 class="section-title">기본 정보</h2>
            <div class="form-group">
                <label for="name">이름</label>
                <input type="text" class="form-control" id="name" name="seniorName"
                       placeholder="이름을 입력하세요." required>
            </div>
            <div class="form-group">
                <label for="gender">성별:</label>
                <select class="form-control" id="gender" name="seniorGender">
                    <option value="M">남성</option>
                    <option value="F">여성</option>
                </select>
            </div>
            <div class="form-group">
                <label for="tel">전화번호</label>
                <input type="text" class="form-control" id="tel" name="seniorTel" placeholder="전화번호 입력"
                       maxlength="11" required>
                <small id="telMessage" class="form-text"></small>
            </div>
            <div class="form-group">
                <label for="birthday">생년월일</label>
                <input type="date" class="form-control" id="birthday" name="seniorBirth">
            </div>
            <div class="form-group">
                <label for="significant">중요 사항</label>
                <textarea class="form-control" id="significant" name="seniorSignificant" rows="3"
                          placeholder="중요 사항을 입력하세요"></textarea>
            </div>
        </div>

        <!-- 주소 정보 섹션 -->
        <div class="form-section">
            <h2 class="section-title">주소 정보</h2>
            <div class="form-group">
                <label for="zipcode">우편번호</label>
                <div class="input-group">
                    <input type="text" class="form-control" id="zipcode" name="seniorZipcode"
                           placeholder="우편번호를 검색하세요" readonly required>
                    <button type="button" id="zipcodeBtn">우편번호 검색</button>
                </div>
            </div>
            <div class="form-group">
                <label for="streetAddr">도로명 주소</label>
                <input type="text" class="form-control" id="streetAddr" name="seniorStreetAddr"
                       placeholder="주소를 입력하세요" readonly required>
            </div>
            <div class="form-group">
                <label for="detailAddr2">상세주소 1</label>
                <input type="text" class="form-control" id="detailAddr2" name="seniorDetailAddr2"
                       placeholder="상세주소 1을 입력하세요" readonly required>
            </div>
            <div class="form-group">
                <label for="detailAddr1">상세주소 2</label>
                <input type="text" class="form-control" id="detailAddr1" name="seniorDetailAddr1"
                       placeholder="상세주소 2를 입력하세요">
            </div>
        </div>

        <input type="hidden" id="latitude" name="seniorLatitude">
        <input type="hidden" id="longitude" name="seniorLongitude">
        <input type="hidden" name="userId" value="${sessionScope.principal}">

        <button type="submit" id="btn_add" class="btn btn-primary btn-block border-0">등록하기</button>
    </form>
</div>
<script src="/js/senior.js"></script>