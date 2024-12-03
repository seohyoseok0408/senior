<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Google Calendar Login</title>
</head>
<body>
<h1>Google Calendar 로그인</h1>
<a href="${oauth2_authorize_google_calendar_url}">
    <button>Google로 로그인</button>
</a>
</body>
</html>