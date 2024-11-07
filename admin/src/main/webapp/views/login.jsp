<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html lang="en" class="h-100">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Focus - Bootstrap Admin Dashboard</title>
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="<c:url value='/images/favicon.png' />">
    <link href="<c:url value='/css/style.css' />" rel="stylesheet">
</head>
<script src="<c:url value='/vendor/global/global.min.js' />"></script>
<script src="<c:url value='/js/quixnav-init.js' />"></script>
<script src="<c:url value='/js/custom.min.js' />"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    let login = {
        init: function() {
            $('#loginbtn').click(() => {
                this.login();
            });
        },
        login: function() {
            let data = {
                adminUsername: $("#username").val(),
                adminPassword: $("#password").val(),
            };

            $.ajax({
                type: "POST",
                url: "<c:url value='/api/admin/login' />",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
            }).done(function(resp) {
                alert("SUCCESS TO LOGIN");
                location.href = "<c:url value='/' />";
            }).fail(function(error) {
                alert("FAIL TO LOGIN ! " + error);
                console.error("Error:", error);
            });
        }
    }
    $(function(){
        login.init();
    });
</script>

<body class="h-100">
<div class="authincation h-100">
    <div class="container-fluid h-100">
        <div class="row justify-content-center h-100 align-items-center">
            <div class="col-md-6">
                <div class="authincation-content">
                    <div class="row no-gutters">
                        <div class="col-xl-12">
                            <div class="auth-form">
                                <h4 class="text-center mb-4">Sign in to your account</h4>
                                <form id="loginForm" onsubmit="return false;">
                                    <div class="form-group">
                                        <label><strong>User Name</strong></label>
                                        <input type="text" class="form-control" id="username" placeholder="Enter Username" value="admin1">
                                    </div>
                                    <div class="form-group">
                                        <label><strong>Password</strong></label>
                                        <input type="password" class="form-control" id="password" placeholder="Enter Password" value="adminpass123">
                                    </div>
                                    <div class="form-row d-flex justify-content-between mt-4 mb-2">
                                        <div class="form-group">
                                            <div class="form-check ml-2">
                                                <input class="form-check-input" type="checkbox" id="basic_checkbox_1">
                                                <label class="form-check-label" for="basic_checkbox_1">Remember me</label>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <a href="<c:url value='/page-forgot-password.html' />">Forgot Password?</a>
                                        </div>
                                    </div>
                                </form>
                                <div class="text-center">
                                    <button type="button" id="loginbtn" class="btn btn-primary btn-block">Login</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!--**********************************
    Scripts
***********************************-->


</body>
</html>
