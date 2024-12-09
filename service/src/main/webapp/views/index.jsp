<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!-- Include Header -->
<%@ include file="layout/header.jsp" %>


<!-- Include Center Content Section -->
<c:choose>
    <c:when test="${center == null}">
        <jsp:include page="center.jsp"/>
    </c:when>
    <c:otherwise>
        <jsp:include page="${center}.jsp"/>
    </c:otherwise>
</c:choose>
<div id="principal" style="display: none;">${sessionScope.principal}</div>
<script>
    const serverurl = "${sessionScope.serverurl}";
</script>
<script src="/js/index.js"></script>
<!-- Include Footer -->
<%@ include file="layout/footer.jsp" %>

