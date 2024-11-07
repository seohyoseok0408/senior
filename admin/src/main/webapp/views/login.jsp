<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en" class="h-100">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Focus - Bootstrap Admin Dashboard</title>
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="./images/favicon.png">
    <link href="./css/style.css" rel="stylesheet">
</head>
<script src="./vendor/global/global.min.js"></script>
<script src="./js/quixnav-init.js"></script>
<script src="./js/custom.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
                url: "/api/admin/login",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
            }).done(function(resp) {
                alert("SUCCESS TO LOGIN");
                location.href = "/";
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
                                            <a href="page-forgot-password.html">Forgot Password?</a>
                                        </div>
                                    </div>

                                </form>
                                <div class="text-center">
                                    <button type="button" id = "loginbtn" class="btn btn-primary btn-block">Login</button>
                                </div>
                                <div class="new-account mt-3">
                                    <p>Don't have an account? <a class="text-primary" href="./page-register.html">Sign up</a></p>
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
