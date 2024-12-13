<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<div class="content-body">
    <div class="container-fluid">
        <div class="row">
            <!-- 왼쪽 위: 프로필 사진 -->
            <div class="col-lg-4 text-center">
                <div class="profile-photo">
                    <c:choose>
                        <c:when test="${not empty user.userProfile}">
                            <img src="/imgs/user/${user.userProfile}" style="max-width: 100%; height: auto;" alt="프로필 이미지">
                        </c:when>
                        <c:otherwise>
                            <img src="/images/profile/default-profile.jpg" style="max-width: 100%; height: auto;" alt="Default Profile">
                        </c:otherwise>
                    </c:choose>
                </div>
                <!-- 계약 정보 -->
                <div class="mt-4">
                    <div class="card mb-3">
                        <div class="stat-widget-one card-body d-flex">
                            <div class="stat-icon d-inline-block me-3">
                                <i class="ti-money text-success border-success"></i>
                            </div>
                            <div class="stat-content">
                                <div class="stat-text">계약 금액</div>
                                <div class="stat-digit">
                                    <p>${totalContractAmount} 원</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card mb-3">
                        <div class="stat-widget-one card-body d-flex">
                            <div class="stat-icon d-inline-block me-3">
                                <i class="ti-user text-primary border-primary"></i>
                            </div>
                            <div class="stat-content">
                                <div class="stat-text">연결 시니어 명수</div>
                                <div class="stat-digit">
                                    <p>${seniorCount} 명</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card">
                        <div class="stat-widget-one card-body d-flex">
                            <div class="stat-icon d-inline-block me-3">
                                <i class="ti-layout-grid2 text-pink border-pink"></i>
                            </div>
                            <div class="stat-content">
                                <div class="stat-text">계약 유지 회수</div>
                                <div class="stat-digit">
                                    <p>${contractRenewalCount} 회</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 오른쪽 위: 이름, 아이디, 휴대폰 번호, 수정 폼 -->
            <div class="col-lg-8">
                <div class="card">
                    <div class="card-body">
                        <!-- 큼직한 이름, 생일, 휴대폰 번호 표시 -->
                        <div class="text-center mb-4">
                            <h1 class="display-4 text-primary">${user.userName}</h1>
                            <p class="h5 mb-2">
                                생년월일 :
                                ${user.userBirthday}
                            </p>
                            <p class="h5">
                                전화번호 :
                                <c:set var="telFormatted" value="${user.userTel}" />
                                ${telFormatted.substring(0, 3)} - ${telFormatted.substring(3, 7)} - ${telFormatted.substring(7)}
                            </p>
                        </div>

                        <h5 class="text-primary">고객 정보 수정</h5>
                        <form id="updateUserForm" action="<c:url value='/api/user/updateUser' />" method="post"
                              onsubmit="return validateForm()">
                            <input type="hidden" name="userId" value="${user.userId}"/>
                            <div class="form-group">
                                <label for="userEmail">Email</label>
                                <input type="email" class="form-control" id="userEmail" name="userEmail" value="${user.userEmail}">
                            </div>
                            <div class="form-group">
                                <label for="userZipcode">Address</label>
                                <div class="d-flex align-items-center mb-2">
                                    <input type="text" class="form-control mr-2" id="userZipcode" name="userZipcode" value="${user.userZipcode}" readonly/>
                                    <a href="javascript:void(0);" onclick="popupZipSearch();" class="btn btn-primary px-4">우편번호 찾기</a>
                                </div>
                                <input type="text" class="form-control mb-2" id="userDetailAdd1" name="userDetailAdd1" value="${user.userStreetAddr}" readonly/>
                                <input type="text" class="form-control mb-2" id="userDetailAddr1" name="userDetailAddr1" value="${user.userDetailAddr1}">
                                <input type="text" class="form-control" id="userDetailAddr2" name="userDetailAddr2" value="${user.userDetailAddr2}" readonly>
                            </div>
                            <button type="submit" class="btn btn-primary">Update</button>
                        </form>
                    </div>
                </div>
                <div class="col-lg-12">
                    <h5 class="text-primary">연결 된 시니어</h5>
                    <c:forEach items="${senior}" var="senior">
                        <div class="card mb-3">
                            <div class="row g-0 align-items-center">
                                <!-- 왼쪽 정보 -->
                                <div class="col-md-8">
                                    <div class="card-body text-start">
                                        <h5 class="text-primary">${senior.seniorName}</h5>
                                        <p>${senior.seniorGender == 'male' ? '남성' : '여성'}</p>
                                        <p>
                                            <fmt:formatDate value="${senior.seniorBirth}" pattern="yyyy년 MM월 dd일" />
                                        </p>
                                        <a href="<c:url value='/senior-detail?id=${senior.seniorId}' />" class="btn btn-primary btn-sm">Detail</a>
                                    </div>
                                </div>
                                <!-- 오른쪽 사진 -->
                                <div class="col-md-4 text-center">
                                    <c:choose>
                                        <c:when test="${not empty senior.seniorProfile}">
                                            <img src="/imgs/senior/${senior.seniorProfile}" class="img-fluid rounded srd-profile-image" alt="${senior.seniorName}">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="/static/images/default-profile.png" class="img-fluid rounded srd-profile-image" alt="Default Profile">
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // 기존 JavaScript 코드는 유지됩니다.
    document.getElementById("updateUserForm").addEventListener("submit", function (event) {
        event.preventDefault();

        const formData = new FormData(this);

        fetch("<c:url value='/api/user/updateUser' />", {
            method: "POST",
            body: formData
        })
            .then(response => response.json())
            .then(data => {
                if (data.data === 1) {
                    alert("수정이 완료되었습니다.");
                    window.location.href = window.location.href;
                } else {
                    alert("수정에 실패했습니다.");
                    window.location.href = window.location.href;
                }
            })
            .catch(error => {
                alert("수정 요청 중 오류가 발생했습니다. 다시 시도해주세요.");
                console.error("Error:", error);
                window.location.href = window.location.href;
            });
    });

    function popupZipSearch() {
        new daum.Postcode({
            oncomplete: function (data) {
                var fullAddr = '';
                var extraAddr = '';

                if (data.userSelectedType === 'R') {
                    fullAddr = data.roadAddress;
                } else {
                    fullAddr = data.jibunAddress;
                }

                if (data.userSelectedType === 'R') {
                    if (data.bname !== '') {
                        extraAddr += data.bname;
                    }
                    if (data.buildingName !== '') {
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    fullAddr += (extraAddr !== '' ? ' (' + extraAddr + ')' : '');
                }

                var mainAddr = fullAddr.replace(/\s*\([^)]*\)/, '').trim();
                var buildingNameMatch = fullAddr.match(/\(([^)]+)\)/);

                document.getElementById('userZipcode').value = data.zonecode;
                document.getElementById("userStreetAddr").value = mainAddr;
                document.getElementById("userDetailAddr2").value = buildingNameMatch ? buildingNameMatch[1] : "";

                document.getElementById("userDetailAddr1").focus();
            }
        }).open();
    }
</script>
