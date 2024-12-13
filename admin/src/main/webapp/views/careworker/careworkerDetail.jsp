<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<div class="content-body">
    <div class="container-fluid">
        <div class="row">
            <!-- 왼쪽: 프로필 사진과 통계 -->
            <div class="col-lg-4 text-center">
                <div class="profile-photo">
                    <c:choose>
                        <c:when test="${not empty user.cwProfile}">
                            <img src="/imgs/careworker/${user.cwProfile}" style="max-width: 100%; height: auto;" alt="프로필 이미지">
                        </c:when>
                        <c:otherwise>
                            <img src="/images/profile/default-profile.jpg" style="max-width: 100%; height: auto;" alt="Default Profile">
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="mt-4">
                    <div class="col-lg-12 mt-4">
                        <h5 class="text-primary mb-3">Licenses</h5>
                        <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
                            <c:forEach items="${licenses}" var="license">
                                <div class="col">
                                    <div class="card h-100">
                                        <div class="card-body text-center">
                                            <h5 class="card-title text-primary">${license.licenseName}</h5>
                                            <p class="card-text">Start Date: ${license.licenseStartDate}</p>
                                            <p class="card-text">End Date: ${license.licenseEndDate}</p>
                                            <p class="card-text">Status:
                                                <span class="${license.licenseStatus == 1 ? 'text-success' : 'text-danger'}">
                                                        ${license.licenseStatus == 1 ? 'Valid' : 'Expired'}
                                                </span>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                </div>
            </div>

            <!-- 오른쪽: 보호사 정보 수정 -->
            <div class="col-lg-8">
                <div class="card mt-3">
                    <div class="card-body">

                        <h5 class="text-primary">Edit Careworker Information</h5>
                        <form id="updateCareworkerForm" action="<c:url value='/api/careworker/update' />" method="post">
                            <input type="hidden" name="cwId" value="${user.cwId}"/>
                            <input type="hidden" name="cwUsername" value="${user.cwUsername}"/>

                            <!-- 이름, 이메일, 전화번호 입력 -->
                            <c:forEach var="field" items="${['cwName:Name', 'cwEmail:Email', 'cwTel:Phone']}">
                                <div class="form-group">
                                    <label for="${field.split(':')[0]}">${field.split(':')[1]}</label>
                                    <input type="text" class="form-control" id="${field.split(':')[0]}" name="${field.split(':')[0]}"
                                           value="${user[field.split(':')[0]]}">
                                </div>
                            </c:forEach>

                            <!-- 주소 입력 필드 -->
                            <div class="form-group">
                                <label for="cwZipcode">Address</label>
                                <div class="d-flex align-items-center mb-2">
                                    <input type="text" class="form-control mr-2" id="cwZipcode" name="cwZipcode" placeholder="우편번호"
                                           value="${user.cwZipcode}" readonly/>
                                    <button type="button" onclick="popupZipSearch();" class="btn btn-primary px-4">우편번호 찾기</button>
                                </div>
                                <input type="text" class="form-control mb-2" id="cwStreetAddr" name="cwStreetAddr" placeholder="Street"
                                       value="${user.cwStreetAddr}" readonly/>
                                <input type="text" class="form-control mb-2" id="cwDetailAddr1" name="cwDetailAddr1" placeholder="Apartment"
                                       value="${user.cwDetailAddr1}">
                                <input type="text" class="form-control" id="cwDetailAddr2" name="cwDetailAddr2" placeholder="Building Name"
                                       value="${user.cwDetailAddr2}" readonly>
                            </div>

                            <!-- 상태와 소개 -->
                            <div class="form-group">
                                <label for="cwStatus">Status</label>
                                <select class="form-control" id="cwStatus" name="cwStatus">
                                    <c:forEach var="status" items="${['ACTIVE:ACTIVE', 'INACTIVE:INACTIVE', 'WAITING:WAITING']}">
                                        <option value="${status.split(':')[0]}"
                                            ${user.cwStatus == status.split(':')[0] ? 'selected' : ''}>
                                                ${status.split(':')[1]}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="cwIntro">Introduction</label>
                                <textarea class="form-control" id="cwIntro" name="cwIntro">${user.cwIntro}</textarea>
                            </div>

                            <button type="submit" class="btn btn-primary">Update</button>
                        </form>
                    </div>
                </div>

                <!-- 자격증 리스트 -->
                <div class="col-lg-12">
                    <h5 class="text-primary">Licenses</h5>
                    <c:forEach items="${licenses}" var="license">
                        <div class="card mb-3">
                            <div class="card-body text-center">
                                <h5 class="text-primary">${license.licenseName}</h5>
                                <p>Start Date: ${license.licenseStartDate}</p>
                                <p>End Date: ${license.licenseEndDate}</p>
                                <p>Status: ${license.licenseStatus == 1 ? 'Valid' : 'Expired'}</p>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.getElementById("updateCareworkerForm").addEventListener("submit", function (event) {
        event.preventDefault(); // 기본 동작 방지

        fetch(this.action, {
            method: "POST",
            body: new FormData(this)
        })
            .then(response => response.json())
            .then(data => {
                alert(data.data === 1 ? "수정이 완료되었습니다." : "수정에 실패했습니다.");
                window.location.reload(); // 페이지 새로고침
            })
            .catch(error => {
                alert("수정 요청 중 오류가 발생했습니다. 다시 시도해주세요.");
                console.error("Error:", error);
                window.location.reload();
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

                document.getElementById('cwZipcode').value = data.zonecode;
                document.getElementById("cwStreetAddr").value = mainAddr;
                document.getElementById("cwDetailAddr2").value = buildingNameMatch ? buildingNameMatch[1] : "";

                document.getElementById("cwDetailAddr1").focus();
            }
        }).open();
    }
</script>
