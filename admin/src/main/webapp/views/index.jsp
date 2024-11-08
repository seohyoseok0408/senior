<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="layout/header.jsp" %>
<!-- Header -->

<!-- Sidebar -->
<%@ include file="layout/sidebar.jsp" %>
<!-- Sidebar End -->

<!-- Content Body -->
<c:choose>
    <c:when test="${center == null}">
        <jsp:include page="center.jsp"></jsp:include>
    </c:when>
    <c:otherwise>
        <jsp:include page="${center}.jsp"></jsp:include>
    </c:otherwise>
</c:choose>
<!-- Content Body End -->

<%@ include file="layout/footer.jsp" %>
<!-- Footer -->
