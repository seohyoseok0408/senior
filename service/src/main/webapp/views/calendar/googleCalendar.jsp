<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="content-body">
    <div class="container-fluid">
        <h1>Google Calendar Events</h1>

        <c:if test="${not empty error}">
            <div style="color: red;">${error}</div>
        </c:if>

        <c:choose>
            <c:when test="${empty authorizedClient}">
                <p>Google Calendar에 접근하려면 로그인이 필요합니다.</p>
                <form action="${oauth2_authorize_google_calendar_url}" method="get">
                    <button type="submit" class="btn btn-primary">Google 로그인</button>
                </form>
            </c:when>
            <c:otherwise>
                <c:if test="${not empty events}">
                    <ul>
                        <c:forEach var="event" items="${events}">
                            <li>
                                <strong>${event.summary}</strong> -
                                <span>${event.start.dateTime != null ? event.start.dateTime : event.start.date}</span>
                            </li>
                        </c:forEach>
                    </ul>
                </c:if>

                <c:if test="${empty events}">
                    <p>등록된 Google Calendar 이벤트가 없습니다.</p>
                </c:if>
            </c:otherwise>
        </c:choose>
    </div>
</div>
