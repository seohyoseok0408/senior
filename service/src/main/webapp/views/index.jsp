<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <title>Senior Care</title>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
  <link rel="stylesheet" href="css/style.css" />
</head>
<body>

<!-- Include Header -->
<%@ include file="header.jsp" %>

<!-- Include Center Content Section -->
<c:choose>
    <c:when test="${center == null}">
        <jsp:include page="center.jsp" />
    </c:when>
    <c:otherwise>
        <jsp:include page="${center}.jsp" />
    </c:otherwise>
</c:choose>

<!-- Include Footer -->
<%@ include file="footer.jsp" %>

<script src="js/bootstrap.js"></script>
</body>
</html>
