<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
    let login = {
        init: function () {
            $('#loginbtn').click(() => {
                this.login();
            });
        },
        login: function () {
            let data = {
                userUsername: $("#username").val(),
                userPassword: $("#password").val(),
            };

            $.ajax({
                type: "POST",
                url: "/api/users/login",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
            }).done(function (resp) {
                if (resp.status === 200 && resp.data === "1") {
                    location.href = "/";
                } else {
                    alert(resp.data); // 예외 메시지를 사용자에게 표시
                }
            }).fail(function (error) {
                alert("서버와의 통신 중 오류가 발생했습니다.");
                console.error("Error:", error);
            });
        }
    }
    $(function () {
        login.init();
    })
</script>

<div class="container" style=" max-width: 400px;">
        <div class="card-body text-center">
            <!-- 타이틀 -->
            <h3 class="card-title mb-3" style="color: #249d57; font-weight: bold;">고객 로그인</h3>
            <p class="mb-4" style="color: #666;">시니어케어에 오신 것을 환영합니다!</p>

            <!-- 로그인 폼 -->
            <form>
                <div class="form-group mb-3">
                    <input type="text" class="form-control" id="username" name="username"
                           placeholder="아이디 입력" style="border-radius: 8px; height: 48px;" value="jin14410" required>
                </div>
                <div class="form-group mb-3">
                    <input type="password" class="form-control" id="password" name="password"
                           placeholder="비밀번호 입력" style="border-radius: 8px; height: 48px;" value="jin553300?" required>
                </div>
                <div class="form-check d-flex align-items-center justify-content-start mb-3">
                    <input type="checkbox" class="form-check-input" id="rememberMe" style="margin-right: 0.5rem;">
                    <label for="rememberMe" class="form-check-label" style="color: #666;">아이디 저장</label>
                </div>
                <button type="button" id="loginbtn" class="btn btn-block"
                        style="background-color: #dff2e1; border: none; height: 48px; border-radius: 8px; color: #249d57; font-size: 16px;">
                    로그인
                </button>
            </form>

            <!-- 비밀번호 찾기와 회원가입 -->
            <div class="mt-3 d-flex justify-content-between">
                <a href="/forgot-password" style="color: #666; text-decoration: none; font-size: 14px;">아이디/비밀번호 찾기</a>
                <a href="/signup/user" style="color: #666; text-decoration: none; font-size: 14px;">회원가입</a>
            </div>

            <!-- SNS 로그인 -->
            <div class="mt-4">
                <p style="color: #666; font-size: 14px;">SNS 간편로그인</p>
                <div class="d-flex justify-content-center">
                    <a href="https://kauth.kakao.com/oauth/authorize?client_id=64b9ea9d9f0617efc1cffc0e66813e95&redirect_uri=http://127.0.0.1/auth/kakao/callback&response_type=code"
                       class="btn" style="background-color: transparent; border: none; border-radius: 50%; width: 48px; height: 48px; padding: 0; display: flex; align-items: center; justify-content: center;">
                        <img src="/images/kakao.png" alt="" style="width: 40px; height: 40px;">
                    </a>
                    <button class="btn" style="background-color: transparent; border: none; border-radius: 50%; width: 48px; height: 48px; padding: 0; display: flex; align-items: center; justify-content: center;">
                        <img src="/images/naver.png" alt="" style="width: 40px; height: 40px;">
                    </button>
                </div>
            </div>
        </div>
</div>
