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
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,700|Poppins:400,500,700&display=swap"
          rel="stylesheet"/>
    <link href="value='https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css'" rel="stylesheet"/>
    <link href="/css/style.css" rel="stylesheet"/>
    <link href="/css/responsive.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.4.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=24292fb5ce2d2498c2ed88d0a951d790&libraries=services"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-bs4.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-bs4.min.js"></script>
</head>

<body>
<div class="hero_area">
    <header class="header_section">
        <div class="container-fluid">
            <nav class="navbar navbar-expand-lg custom_nav-container">
                <a class="navbar-brand" href="/">
                    <span>Senior Care</span>
                </a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <div class="user_option ml-auto">
                        <%-- 고객 메뉴 --%>
                        <c:if test="${sessionScope.role == 'USER'}">
                            <a href="/user/careworkers">보호사 신청</a>
                            <a href="/user/seniors">시니어 관리</a>
                            <a href="/schedule">일정관리</a>
                            <a href="/help">문의</a>
                            <a href="/user/mypage">마이페이지</a>
                        </c:if>

                        <%-- 보호사 메뉴 --%>
                        <c:if test="${sessionScope.role == 'CAREWORKER'}">
                            <a href="/senior-list">시니어 리스트</a>
                            <a href="/contact">계약관리</a>
                            <a href="/cwschedule">일정관리</a>
                            <a href="/cwmypage">마이페이지</a>
                        </c:if>

                        <!-- 로그인/로그아웃 -->
                        <c:choose>
                            <c:when test="${not empty sessionScope.principal}">
                                <a href="/logout"><span>로그아웃</span></a>
                            </c:when>
                            <c:otherwise>
                                <a href="/login" data-toggle="modal" data-target="#loginModal"><span>로그인</span></a>
                                <a href="/signup" data-toggle="modal" data-target="#signModal"><span>회원가입</span></a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </nav>
        </div>
    </header>
</div>
<%@ include file="../auth/login/modal-login.jsp" %>
<%@ include file="../auth/signup/modal-signup.jsp" %>
