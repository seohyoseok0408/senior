<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>SeniorCare</title>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <link rel="stylesheet" type="text/css"
          href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css"/>
    <link rel="stylesheet" type="text/css" href="/css/bootstrap.css"/>
    <link href="/css/font-awesome.min.css'" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link href="value='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css'" rel="stylesheet"/>
    <link href="/css/style.css" rel="stylesheet"/>
    <link href="/css/responsive.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.4.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=24292fb5ce2d2498c2ed88d0a951d790&libraries=services,clusterer,drawing"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-bs4.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-bs4.min.js"></script>
</head>

<style>
    body {
        font-family: 'Noto Sans KR', sans-serif;
    }

    .header_section {
        background: white;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }

    .navbar-brand {
        font-size: 28px;
        font-weight: 700;
        color: #40c057;
        transition: color 0.3s ease;
    }

    .navbar-brand:hover {
        color: #2f9e44;
    }

    .nav-link {
        color: #333 !important;
        font-weight: 500;
        position: relative;
        padding: 20px 15px !important;
        transition: color 0.3s ease;
    }

    .nav-link:hover {
        color: #40c057 !important;
    }

    .nav-link::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 50%;
        width: 0;
        height: 2px;
        background-color: #40c057;
        transition: all 0.3s ease;
    }

    .nav-link:hover::after {
        width: 100%;
        left: 0;
    }

    .user_option {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 20px;
    }

    .user_option a {
        color: #333;
        text-decoration: none;
        padding: 8px 12px;
        font-weight: 500;
        transition: all 0.3s ease;
    }

    .user_option a:hover {
        color: #40c057;
    }

    .auth-buttons {
        display: flex;
        gap: 10px;
    }

    .auth-buttons a {
        background-color: transparent;
        color: #40c057 !important;
        padding: 8px 16px !important;
        border-radius: 50px;
        font-weight: 500;
        transition: all 0.3s ease;
        text-decoration: none;
        border: 2px solid #40c057;
    }

    .auth-buttons a:hover {
        background-color: #40c057;
        color: white !important;
        transform: translateY(-2px);
        box-shadow: 0 4px 10px rgba(64, 192, 87, 0.2);
    }

    .user-info {
        display: flex;
        align-items: center;
        gap: 15px;
    }

    .user-info p {
        margin: 0;
        color: #333;
        font-weight: 500;
    }

    .navbar-collapse {
        justify-content: center;
    }

    .ml-auto {
        margin-left: 0 !important;
    }
</style>

<body>
<div class="hero_area">
    <header class="header_section">
        <div class="container-fluid">
            <nav class="navbar navbar-expand-lg custom_nav-container">
                <a class="navbar-brand" href="/">
                    <span>Senior Care</span>
                </a>
                <button class="navbar-toggler" type="button" data-toggle="collapse"
                        data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                        aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <div class="user_option">
                        <%-- 고객 메뉴 --%>
                        <c:if test="${sessionScope.role == 'USER'}">
                            <a href="/user/careworkers">보호사 신청</a>
                            <a href="/user/senior">시니어 관리</a>
                            <a href="/user/map">지도보기</a>
                            <a href="/fullcalendar-u">일정관리</a>
                            <a href="/help">문의</a>
                            <a href="/user/mypage">내 정보</a>
                        </c:if>

                        <%-- 보호사 메뉴 --%>
                        <c:if test="${sessionScope.role == 'CAREWORKER'}">
                            <a href="/senior-list">시니어 리스트</a>
                            <a href="/careworker/contracts">계약관리</a>
                            <a href="/fullcalendar-cw">일정관리</a>
                            <a href="/cwmypage">내 정보</a>
                        </c:if>
                    </div>
                </div>
                <!-- 로그인/로그아웃 -->
                <div class="auth-buttons">
                    <c:choose>
                        <c:when test="${not empty sessionScope.principal}">
                            <div class="user-info">
                                <c:if test="${sessionScope.role == 'USER'}">
                                    <p>${sessionScope.name}고객님</p>
                                </c:if>
                                <c:if test="${sessionScope.role == 'CAREWORKER'}">
                                    <p>${sessionScope.name}보호사님</p>
                                </c:if>
                                <a href="/logout">로그아웃</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <a href="/login" data-toggle="modal" data-target="#loginModal">로그인</a>
                            <a href="/signup" data-toggle="modal" data-target="#signModal">회원가입</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </nav>
        </div>
    </header>
</div>
<%@ include file="../auth/login/modal-login.jsp" %>
<%@ include file="../auth/signup/modal-signup.jsp" %>
