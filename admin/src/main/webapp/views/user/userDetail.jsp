<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<div class="content-body">
    <div class="container-fluid">
        <!-- 유저 프로필 헤더 -->
        <div class="profile">
            <div class="profile-head">
                <div class="photo-content">
                    <div class="cover-photo"></div>
                    <div class="profile-photo">
                        <img src="images/profile/${user.userProfile}" class="img-fluid rounded-circle" alt="프로필 이미지">
                    </div>
                </div>
                <div class="profile-info text-center mt-3">
                    <h4 class="text-primary">${user.userName}</h4>
                    <p class="mb-1">ID: ${user.userUsername}</p>
                    <p>Email: ${user.userEmail}</p>
                    <p>Phone: ${user.userTel}</p>
                </div>
            </div>
        </div>

        <!-- 유저 상세 정보 -->
        <div class="row mt-4">
            <div class="col-lg-8">
                <!-- 수정 가능한 폼 -->
                <div class="card mt-3">
                    <div class="card-body">
                        <h5 class="text-primary">Edit User Information</h5>
                        <form action="updateUser" method="post">
                            <div class="form-group">
                                <label for="userName">Name</label>
                                <input type="text" class="form-control" id="userName" name="userName" value="${user.userName}">
                            </div>
                            <div class="form-group">
                                <label for="userEmail">Email</label>
                                <input type="email" class="form-control" id="userEmail" name="userEmail" value="${user.userEmail}">
                            </div>
                            <div class="form-group">
                                <label for="userTel">Phone</label>
                                <input type="text" class="form-control" id="userTel" name="userTel" value="${user.userTel}">
                            </div>

                            <!-- 주소 입력 필드 및 우편번호 검색 버튼 -->
                            <div class="form-group">
                                <label for="userZipcode">Address</label>
                                <div class="d-flex align-items-center mb-2">
                                    <input type="text" class="form-control mr-2" id="userZipcode" name="userZipcode" placeholder="우편번호" value="${user.userZipcode}" readonly />
                                    <a href="javascript:void(0);" onclick="popupZipSearch(); return false;" class="btn btn-primary px-4">우편번호 찾기</a>
                                </div>
                                <input type="text" class="form-control mb-2" id="userDetailAdd1" name="userDetailAdd1" placeholder="Street" value="${user.userDetailAdd1}" readonly />
                                <input type="text" class="form-control mb-2" id="userDetailAddr1" name="userDetailAddr1" placeholder="Apartment" value="${user.userDetailAddr1}">
                                <input type="text" class="form-control" id="userDetailAddr2" name="userDetailAddr2" placeholder="Building Name" value="${user.userDetailAddr2}"readonly>
                            </div>


                            <div class="form-group">
                                <label for="userStatus">Status</label>
                                <select class="form-control" id="userStatus" name="userStatus">
                                    <option ${user.userStatus == 'Active' ? 'selected' : ''}>Active</option>
                                    <option ${user.userStatus == 'Inactive' ? 'selected' : ''}>Inactive</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary">Update</button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- 추가적인 유저 정보나 활동 내역 등을 표시할 영역 -->
            <div class="col-lg-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="text-primary">Activity</h5>
                        <p class="mb-1">최근 활동: 주문 3건, 리뷰 작성 2건</p>
                        <p class="mb-1">팔로워 수: 120명</p>
                        <div class="mt-4 text-center">
                            <a href="javascript:void(0)" class="btn btn-primary btn-sm">Follow</a>
                            <a href="javascript:void(0)" class="btn btn-dark btn-sm">Message</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function popupZipSearch(){
        new daum.Postcode({
            oncomplete: function(data) {
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                if (data.userSelectedType === 'R') { // 도로명 주소
                    fullAddr = data.roadAddress;
                } else { // 지번 주소
                    fullAddr = data.jibunAddress;
                }

                // 도로명 주소에 추가 정보가 있을 경우
                if(data.userSelectedType === 'R'){
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 주소와 괄호 내용을 분리
                var mainAddr = fullAddr.replace(/\s*\([^)]*\)/, '').trim(); // 괄호 포함 내용을 제거한 주소
                var buildingNameMatch = fullAddr.match(/\(([^)]+)\)/); // () 안의 텍스트 추출

                // 우편번호와 주소 필드에 입력
                document.getElementById('userZipcode').value = data.zonecode;
                document.getElementById("userDetailAdd1").value = mainAddr; // 괄호 제외 주소
                document.getElementById("userDetailAddr2").value = buildingNameMatch ? buildingNameMatch[1] : ""; // 괄호 안의 내용

                // 상세 주소 입력 필드로 포커스 이동
                document.getElementById("userDetailAddr1").focus();
            }
        }).open();
    }
</script>

