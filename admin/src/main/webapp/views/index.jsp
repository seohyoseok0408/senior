<%@ page contentType="text/html;charset=UTF-8" language="java" %>

    <%@ include file="layout/header.jsp"%>
    <!--**********************************
        Header end ti-comment-alt
    ***********************************-->

    <!--**********************************
        Sidebar start
    ***********************************-->
    <c:choose>
    <c:when test="${sidebar == null}">
        <jsp:include page="sidebar.jsp"></jsp:include>
    </c:when>
    <c:otherwise>
        <jsp:include page="${sidebar}.jsp"></jsp:include>
    </c:otherwise>
    </c:choose>
    <!--**********************************
        Sidebar end
    ***********************************-->

    <!--**********************************
        Content body start
    ***********************************-->
    <c:choose>
    <c:when test="${center == null}">
        <jsp:include page="center.jsp"></jsp:include>
    </c:when>
    <c:otherwise>
        <jsp:include page="${center}.jsp"></jsp:include>
    </c:otherwise>
    </c:choose>
    <!--**********************************
        Content body end
    ***********************************-->
    <%@ include file="layout/footer.jsp"%>

