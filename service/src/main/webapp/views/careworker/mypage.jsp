<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="mypage-container">
    <div class="profile-section">
        <!-- 왼쪽 사이드바 -->
        <div class="profile-sidebar">
            <div class="profile-info">
                <img alt="프로필 이미지" class="profile-image">
                <h3 class="profile-name" id="profileName"></h3>
                <p class="profile-email" id="profileEmail"></p>
                <div class="profile-actions">
                    <button class="btn btn-primary" onclick="mypage.showSection('updateSection')">
                        <i class="fas fa-edit"></i> 프로필 수정
                    </button>
                </div>
            </div>
            <ul class="menu-list">
                <li class="menu-item" onclick="mypage.showSection('infoSection')">
                    <i class="fas fa-user"></i>
                    <p>내 정보</p>
                </li>
                <li class="menu-item" onclick="mypage.showSection('updateSection')">
                    <i class="fas fa-cog"></i>
                    <p>회원정보 수정</p>
                </li>
                <li class="menu-item" onclick="mypage.showSection('passwordSection')">
                    <i class="fas fa-lock"></i>
                    <p>비밀번호 변경</p>
                </li>
                <li class="menu-item" onclick="mypage.showSection('deleteSection')">
                    <i class="fas fa-user-times"></i>
                    <p>회원 탈퇴</p>
                </li>
            </ul>
        </div>

        <!-- 오른쪽 컨텐츠 -->
        <div class="content-section">
            <!-- 내 정보 섹션 -->
            <div id="infoSection">
                <h2 class="section-title">내 정보</h2>
                <div class="info-grid">
                    <div class="info-item">
                        <div class="info-label">이름</div>
                        <div class="info-value" id="cwName"></div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">이메일</div>
                        <div class="info-value" id="cwEmail"></div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">전화번호</div>
                        <div class="info-value" id="cwTel"></div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">경력</div>
                        <div class="info-value" id="cwIntro"></div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">우편번호</div>
                        <div class="info-value" id="cwZipcode"></div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">주소</div>
                        <div class="info-value" id="cwStreetAddr"></div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">상세주소</div>
                        <div class="info-value">
                            <span id="cwDetailAddr1"></span>
                            <span id="cwDetailAddr2"></span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 회원정보 수정 섹션 -->
            <div id="updateSection" style="display: none;">
                <h2 class="section-title">회원정보 수정</h2>
                <form id="updateForm">
                    <div class="form-group">
                        <label class="form-label">이름</label>
                        <input type="text" class="form-control" id="updateName" name="cwName" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">이메일</label>
                        <input type="email" class="form-control" id="updateEmail" name="cwEmail" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">전화번호</label>
                        <input type="tel" class="form-control" id="updateTel" name="cwTel" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">경력</label>
                        <input type="text" class="form-control" id="updateIntro" name="cwIntro" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">우편번호</label>
                        <input type="text" readonly class="form-control" id="updateZipcode" name="cwZipcode">
                    </div>
                    <div class="form-group">
                        <label class="form-label">주소</label>
                        <input type="text" readonly class="form-control" id="updateStreetAddr" name="cwStreetAddr">
                    </div>
                    <div class="form-group">
                        <label class="form-label">상세주소</label>
                        <input type="text" readonly class="form-control" id="updateDetailAddr1" name="cwDetailAddr1">
                    </div>
                    <div class="form-group">
                        <label class="form-label">추가 상세주소</label>
                        <input type="text" class="form-control" id="updateDetailAddr2" name="cwDetailAddr2">
                    </div>
                    <button type="button" class="btn btn-primary" onclick="mypage.updateCwInfo()">
                        <i class="fas fa-check"></i> 수정하기
                    </button>
                </form>
            </div>

            <!-- 비밀번호 변경 섹션 -->
            <div id="passwordSection" style="display: none;">
                <h2 class="section-title">비밀번호 변경</h2>
                <form id="passwordForm">
                    <div class="form-group">
                        <label class="form-label">새 비밀번호</label>
                        <input type="password" class="form-control" id="newPassword" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">비밀번호 재확인</label>
                        <input type="password" class="form-control" id="confirmPassword" required>
                    </div>
                    <button type="button" class="btn btn-primary" onclick="mypage.updatePassword()">
                        <i class="fas fa-key"></i> 비밀번호 변경
                    </button>
                </form>
            </div>

            <!-- 회원 탈퇴 섹션 -->
            <div id="deleteSection" style="display: none;">
                <h2 class="section-title">회원 탈퇴</h2>
                <div class="alert-danger">
                    <h4 class="alert-heading">
                        <i class="fas fa-exclamation-triangle"></i> 주의!
                    </h4>
                    <p>회원 탈퇴 시 모든 정보가 삭제되며 복구할 수 없습니다.</p>
                </div>
                <p>정말로 회원 탈퇴를 진행하시겠습니까?</p>
                <button class="btn btn-danger" onclick="mypage.deleteAccount()">
                    <i class="fas fa-cw-times"></i> 탈퇴하기
                </button>
            </div>
        </div>
    </div>
</div>

<script>
    const cwId = '${cwId}';
    const mypage = {
        init: function () {
            this.loadCwInfo();
            this.showSection('infoSection');
        },

        loadCwInfo: function () {
            fetch(`/api/careworkers/${cwId}`)
                .then(response => {
                    if (!response.ok) throw new Error("사용자 정보를 불러오는데 실패했습니다.");
                    return response.json();
                })
                .then(data => {
                    const cw = data.data;
                    if (cw) {
                        this.updateCwInfoDisplay(cw);
                        this.populateUpdateForm(cw);
                        this.updateProfileDisplay(cw);
                    }
                })
                .catch(error => {
                    alert("사용자 정보를 불러오는데 실패했습니다.");
                    console.error("사용자 정보 로드 오류:", error);
                });

        },

        updateCwInfoDisplay: function (cw) {
            document.getElementById("cwName").textContent = cw.cwName || "없음";
            document.getElementById("cwEmail").textContent = cw.cwEmail || "없음";
            document.getElementById("cwTel").textContent = cw.cwTel || "없음";
            document.getElementById("cwIntro").textContent = cw.cwIntro || "없음";
            document.getElementById("cwZipcode").textContent = cw.cwZipcode || "없음";
            document.getElementById("cwStreetAddr").textContent = cw.cwStreetAddr || "없음";
            document.getElementById("cwDetailAddr1").textContent = cw.cwDetailAddr1 || "없음";
            document.getElementById("cwDetailAddr2").textContent = cw.cwDetailAddr2 || "없음";
        },

        updateProfileDisplay: function (cw) {
            document.getElementById("profileName").textContent = cw.cwName || "이름 없음";
            document.getElementById("profileEmail").textContent = cw.cwEmail || "이메일 없음";
        },

        populateUpdateForm: function (cw) {
            document.getElementById("updateName").value = cw.cwName || "";
            document.getElementById("updateEmail").value = cw.cwEmail || "";
            document.getElementById("updateTel").value = cw.cwTel || "";
            document.getElementById("updateIntro").value = cw.cwIntro || "";
            document.getElementById("updateZipcode").value = cw.cwZipcode || "";
            document.getElementById("updateStreetAddr").value = cw.cwStreetAddr || "";
            document.getElementById("updateDetailAddr1").value = cw.cwDetailAddr1 || "";
            document.getElementById("updateDetailAddr2").value = cw.cwDetailAddr2 || "";
        },

        updateCwInfo: function () {
            const formData = new FormData(document.getElementById("updateForm"));
            const updatedInfo = Object.fromEntries(formData.entries());

            fetch(`/api/careworkers/update/${cwId}`, {
                method: "PUT",
                headers: {"Content-Type": "application/json"},
                body: JSON.stringify(updatedInfo)
            })
                .then(response => {
                    if (!response.ok) throw new Error("회원정보 수정 실패");
                    return response.json();
                })
                .then(data => {
                    if (data.status === 200) {
                        alert("회원정보가 성공적으로 수정되었습니다.");
                        this.loadCwInfo(); // 정보 갱신
                        this.showSection("infoSection");
                    } else {
                        alert(`회원정보 수정 실패: ${data.data || "알 수 없는 오류"}`);
                    }
                })
                .catch(error => {
                    console.error("회원정보 수정 오류:", error);
                    alert("회원정보 수정 중 오류가 발생했습니다.");
                });
        },


        updatePassword: function () {
            const newPassword = document.getElementById("newPassword").value;
            const confirmPassword = document.getElementById("confirmPassword").value;

            if (newPassword !== confirmPassword) {
                alert("새 비밀번호와 확인 비밀번호가 일치하지 않습니다.");
                return;
            }

            fetch(`/api/careworkers/update/password/${cwId}`, {
                method: "PUT",
                headers: {"Content-Type": "text/plain"},
                body: newPassword
            })
                .then(response => response.json())
                .then(data => {
                    if (data.status === 200) {
                        alert("비밀번호가 성공적으로 변경되었습니다. 다시 로그인해주세요.");
                        this.logout();
                    } else {
                        throw new Error("비밀번호 변경에 실패했습니다.");
                    }
                })
                .catch(error => {
                    console.error("비밀번호 변경 오류:", error);
                    alert("비밀번호 변경에 실패했습니다.");
                });
        },

        deleteAccount: function () {
            if (confirm("정말로 회원 탈퇴를 진행하시겠습니까? 이 작업은 되돌릴 수 없습니다.")) {
                fetch(`/api/careworkers/delete/${cwId}`, {method: "DELETE"})
                    .then(response => response.json())
                    .then(data => {
                        if (data.status === 200) {
                            alert("회원 탈퇴가 완료되었습니다. 메인 페이지로 이동합니다.");
                            this.logout();
                        } else {
                            throw new Error("회원 탈퇴에 실패했습니다.");
                        }
                    })
                    .catch(error => {
                        console.error("회원 탈퇴 오류:", error);
                        alert("회원 탈퇴에 실패했습니다.");
                    });
            }
        },

        logout: function () {
            fetch('/logout', {method: 'POST'})
                .then(() => {
                    window.location.href = "/";
                })
                .catch(error => console.error("로그아웃 오류:", error));
        },

        showSection: function (sectionId) {
            const sections = ['infoSection', 'updateSection', 'passwordSection', 'deleteSection'];
            sections.forEach(section => {
                document.getElementById(section).style.display = section === sectionId ? 'block' : 'none';
            });
        }
    };

    document.addEventListener("DOMContentLoaded", function () {
        mypage.init();
    });
</script>
