<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<div class="content-body">
    <div class="container-fluid">
        <div class="row">
            <!-- Left Column: Profile and Statistics -->
            <div class="col-lg-4 text-center">
                <!-- Profile Photo -->
                <div class="profile-photo">
                    <c:choose>
                        <c:when test="${not empty senior.seniorProfile}">
                            <img src="/imgs/senior/${senior.seniorProfile}" style="max-width: 100%; height: auto;"
                                 alt="프로필 이미지">
                        </c:when>
                        <c:otherwise>
                            <img src="/static/images/default-profile.png" style="max-width: 100%; height: auto;"
                                 alt="Default Profile">
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Statistics Cards -->
                <div class="mt-4">
                    <div class="card mb-2">
                        <div class="stat-widget-one card-body">
                            <div class="stat-icon d-inline-block">
                                <i class="ti-money text-success border-success"></i>
                            </div>
                            <div class="stat-content d-inline-block">
                                <div class="stat-text">총 계약 금액</div>
                                <div class="stat-digit">${totalContractAmount} 원</div>
                            </div>
                        </div>
                    </div>
                    <div class="card mb-2">
                        <div class="stat-widget-one card-body">
                            <div class="stat-icon d-inline-block">
                                <i class="ti-layout-grid2 text-pink border-pink"></i>
                            </div>
                            <div class="stat-content d-inline-block">
                                <div class="stat-text">계약 유지 회수</div>
                                <div class="stat-digit">${contractRenewalCount} 회</div>
                            </div>
                        </div>
                    </div>
                    <div class="card mb-2"
                            <c:if test="${not empty recentContractInfo.userId}">
                                onclick="window.location.href='customer-detail?id=${recentContractInfo.userId}'" style="cursor: pointer;"
                            </c:if>
                            <c:if test="${empty recentContractInfo.userId}">
                                style="cursor: not-allowed; opacity: 0.5;"
                            </c:if>>
                        <div class="stat-widget-one card-body">
                            <div class="stat-icon d-inline-block">
                                <i class="ti-user text-primary border-primary"></i>
                            </div>
                            <div class="stat-content d-inline-block">
                                <div class="stat-text">자녀</div>
                                <div class="stat-digit">
                                    <c:choose>
                                        <c:when test="${not empty recentContractInfo.userName}">${recentContractInfo.userName}</c:when>
                                        <c:otherwise>정보 없음</c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card"
                            <c:if test="${not empty recentContractInfo.careworkerId}">
                                onclick="window.location.href='careworker-detail?id=${recentContractInfo.careworkerId}'" style="cursor: pointer;"
                            </c:if>
                            <c:if test="${empty recentContractInfo.careworkerId}">
                                style="cursor: not-allowed; opacity: 0.5;"
                            </c:if>>
                        <div class="stat-widget-one card-body">
                            <div class="stat-icon d-inline-block">
                                <i class="ti-link text-danger border-danger"></i>
                            </div>
                            <div class="stat-content d-inline-block">
                                <div class="stat-text">연결된 보호자</div>
                                <div class="stat-digit">
                                    <c:choose>
                                        <c:when test="${not empty recentContractInfo.careworkerName}">${recentContractInfo.careworkerName}</c:when>
                                        <c:otherwise>정보 없음</c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right Column: Senior Details and Editable Form -->
            <div class="col-lg-8">
                <div class="card">
                    <div class="card">
                        <div class="card-body">
                            <!-- Senior Details -->
                            <div class="text-center mb-4">
                                <h1 class="display-4 text-primary">${senior.seniorName}</h1>
                                <p class="h5 mb-2">
                                    ID: ${senior.seniorId}
                                </p>
                                <p class="h5">
                                    Phone: ${senior.seniorTel}
                                </p>
                                <p class="h5">
                                    Gender: ${senior.seniorGender == 'male' ? '남성' : '여성'}
                                </p>
                            </div>

                            <h5 class="text-primary">시니어 정보 수정</h5>

                            <form action="updateSenior" method="post">
                                <input type="hidden" name="seniorId" value="${senior.seniorId}"/>
                                <div class="form-group">
                                    <label for="seniorName">Name</label>
                                    <input type="text" class="form-control" id="seniorName" name="seniorName"
                                           value="${senior.seniorName}">
                                </div>
                                <div class="form-group">
                                    <label for="seniorTel">Phone</label>
                                    <input type="text" class="form-control" id="seniorTel" name="seniorTel"
                                           value="${senior.seniorTel}">
                                </div>
                                <div class="form-group">
                                    <label for="seniorBirth">Birth Date</label>
                                    <input type="date" class="form-control" id="seniorBirth" name="seniorBirth"
                                           value="<fmt:formatDate value='${senior.seniorBirth}' pattern='yyyy-MM-dd' />">
                                </div>
                                <div class="form-group">
                                    <label for="seniorZipcode">Address</label>
                                    <div class="d-flex align-items-center mb-2">
                                        <input type="text" class="form-control mr-2" id="seniorZipcode"
                                               name="seniorZipcode" value="${senior.seniorZipcode}" readonly/>
                                        <a href="javascript:void(0);" onclick="popupZipSearch();"
                                           class="btn btn-primary px-4">우편번호 찾기</a>
                                    </div>
                                    <input type="text" class="form-control mb-2" id="seniorStreetAddr"
                                           name="seniorStreetAddr" value="${senior.seniorStreetAddr}" readonly/>
                                    <input type="text" class="form-control mb-2" id="seniorDetailAddr1"
                                           name="seniorDetailAddr1" value="${senior.seniorDetailAddr1}">
                                    <input type="text" class="form-control" id="seniorDetailAddr2"
                                           name="seniorDetailAddr2" value="${senior.seniorDetailAddr2}">
                                </div>
                                <button type="submit" class="btn btn-primary">Update</button>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Health Information -->
                <div class="card mt-4">
                    <div class="card-body">
                        <h5 class="card-title text-primary">Health Information</h5>
                        <c:if test="${not empty healthInfo}">
                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th>Disease Name</th>
                                    <th>Description</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${healthInfo}" var="info">
                                    <tr>
                                        <td>${info.diseaseName}</td>
                                        <td>${info.diseaseDescription}</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </c:if>
                        <c:if test="${empty healthInfo}">
                            <p class="text-muted">No health information available.</p>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<script>
    document.querySelector("form[action='updateSenior']").addEventListener("submit", function (event) {
        event.preventDefault(); // 폼 기본 제출 동작 방지

        const formData = new FormData(this);

        fetch("<c:url value='/api/senior/updateSenior' />", {
            method: "POST",
            body: formData
        })
            .then(response => response.json())
            .then(data => {
                if (data.data === 1) {
                    alert("수정이 완료되었습니다."); // 성공 알림
                    window.location.href = window.location.href; // 현재 페이지 새로고침
                } else {
                    alert("수정에 실패했습니다."); // 실패 알림
                    window.location.href = window.location.href; // 현재 페이지 새로고침
                }
            })
            .catch(error => {
                alert("수정 요청 중 오류가 발생했습니다. 다시 시도해주세요.");
                console.error("Error:", error);
                window.location.href = window.location.href; // 현재 페이지 새로고침
            });
    });

    function popupZipSearch() {
        new daum.Postcode({
            oncomplete: function (data) {
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                if (data.userSelectedType === 'R') { // 도로명 주소
                    fullAddr = data.roadAddress;
                } else { // 지번 주소
                    fullAddr = data.jibunAddress;
                }

                // 도로명 주소에 추가 정보가 있을 경우
                if (data.userSelectedType === 'R') {
                    if (data.bname !== '') {
                        extraAddr += data.bname;
                    }
                    if (data.buildingName !== '') {
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    fullAddr += (extraAddr !== '' ? ' (' + extraAddr + ')' : '');
                }

                // 주소와 괄호 내용을 분리
                var mainAddr = fullAddr.replace(/\s*\([^)]*\)/, '').trim(); // 괄호 포함 내용을 제거한 주소
                var buildingNameMatch = fullAddr.match(/\(([^)]+)\)/); // () 안의 텍스트 추출

                // 우편번호와 주소 필드에 입력
                document.getElementById('seniorZipcode').value = data.zonecode;
                document.getElementById("seniorStreetAddr").value = mainAddr; // 괄호 제외 주소
                document.getElementById("seniorDetailAddr2").value = buildingNameMatch ? buildingNameMatch[1] : ""; // 괄호 안의 내용

                // 상세 주소 입력 필드로 포커스 이동
                document.getElementById("seniorDetailAddr1").focus();
            }
        }).open();
    }
</script>

