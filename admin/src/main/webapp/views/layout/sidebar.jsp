<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="quixnav">
    <div class="quixnav-scroll">
        <ul class="metismenu" id="menu">
            <li class="nav-label">고객 관리</li>
            <li><a class="has-arrow" href="javascript:void()" aria-expanded="false"><i class="icon icon-user"></i><span class="nav-text">고객 관리</span></a>
                <ul aria-expanded="false">
                    <li><a href="<c:url value='/customer-list'/>">고객 리스트</a></li>
                    <li><a href="<c:url value='/customer-detail'/>">고객 상세</a></li>
                </ul>
            </li>

            <li class="nav-label">시니어 관리</li>
            <li><a class="has-arrow" href="javascript:void()" aria-expanded="false"><i class="icon icon-user-female"></i><span class="nav-text">시니어 관리</span></a>
                <ul aria-expanded="false">
                    <li><a href="<c:url value='/senior-list'/>">시니어 리스트</a></li>
                    <li><a href="<c:url value='/senior-detail'/>">시니어 상세</a></li>
                </ul>
            </li>

            <li class="nav-label">보호사 관리</li>
            <li><a class="has-arrow" href="javascript:void()" aria-expanded="false"><i class="icon icon-people"></i><span class="nav-text">보호사 관리</span></a>
                <ul aria-expanded="false">
                    <li><a href="<c:url value='/guardian-list'/>">보호사 리스트</a></li>
                    <li><a href="<c:url value='/guardian-approval'/>">보호사 승인 / 거절</a></li>
                    <li><a href="<c:url value='/guardian-certification'/>">보호사 자격증 상세</a></li>
                </ul>
            </li>

            <li class="nav-label">공지 사항</li>
            <li><a class="has-arrow" href="javascript:void()" aria-expanded="false"><i class="icon icon-bell"></i><span class="nav-text">공지 사항</span></a>
                <ul aria-expanded="false">
                    <li><a href="<c:url value='/notice-list'/>">공지사항 리스트</a></li>
                    <li><a href="<c:url value='/notice-edit'/>">공지사항 작성 / 수정</a></li>
                </ul>
            </li>

            <li class="nav-label">문의 관리</li>
            <li><a class="has-arrow" href="javascript:void()" aria-expanded="false"><i class="icon icon-question"></i><span class="nav-text">문의 관리</span></a>
                <ul aria-expanded="false">
                    <li><a href="<c:url value='/inquiry-list'/>">문의 리스트</a></li>
                    <li><a href="<c:url value='/inquiry-reply'/>">문의 답변 / 수정</a></li>
                </ul>
            </li>
        </ul>
    </div>
</div>
