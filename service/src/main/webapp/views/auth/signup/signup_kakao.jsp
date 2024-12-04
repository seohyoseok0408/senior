<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
    let signup = {
        init: function () {
            $('#btn_add').click(() => {
                if (!this.validateForm()) {
                    alert("입력되지 않거나 올바르지 않은 정보가 있습니다.");
                } else {
                    this.register();
                }
            });

            $('#zipcodeBtn').click(() => {
                this.openPostcode();
            });

            $('#profile').on('change', (e) => this.previewProfileImage(e.target));
        },

        validateForm: function () {
            let isAddressValid = this.validateAddress();
            let isProfileValid = this.validateProfile();

            return isAddressValid && isProfileValid;
        },

        validateAddress: function () {
            let zipcode = $('#zipcode').val();
            let streetAddr = $('#streetAddr').val();
            let detailAddr1 = $('#detailAddr1').val();

            if (zipcode === '' || streetAddr === '' || detailAddr1 === '') {
                alert("주소 정보를 입력하세요.");
                return false;
            }
            return true;
        },

        validateProfile: function () {
            let fileInput = $('#profile').val();
            if (fileInput === '') {
                $('#profileMessage').text('프로필 이미지를 선택해주세요.').removeClass('text-success').addClass('text-danger');
                return false;
            }
            $('#profileMessage').text('프로필 이미지가 업로드되었습니다.').removeClass('text-danger').addClass('text-success');
            return true;
        },

        openPostcode: function () {
            new daum.Postcode({
                oncomplete: function (data) {
                    let roadAddr = data.roadAddress;
                    let extraRoadAddr = '';

                    if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                        extraRoadAddr += data.bname;
                    }
                    if (data.buildingName !== '' && data.apartment === 'Y') {
                        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }

                    $("#zipcode").val(data.zonecode);
                    $("#streetAddr").val(roadAddr);
                    $("#detailAddr2").val(extraRoadAddr);
                }
            }).open();
        },

        previewProfileImage: function (input) {
            const file = input.files[0];
            const preview = $('#profilePreview');
            const message = $('#profileMessage');

            if (file) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    preview.attr('src', e.target.result);
                    message.text('프로필 이미지가 업로드되었습니다.').removeClass('text-danger').addClass('text-success');
                };
                reader.readAsDataURL(file);
            } else {
                preview.attr('src', '/images/default-profile.jpg');
                message.text('프로필 이미지를 선택해주세요.').removeClass('text-success').addClass('text-danger');
            }
        },

        register: function () {
            let form = $('#user_add_form')[0];
            let formData = new FormData(form);

            $.ajax({
                type: 'POST',
                url: '/api/users/signup/kakao',
                data: formData,
                processData: false,
                contentType: false,
                dataType: 'json',
            }).done(function (resp) {
                if (resp.status === 200) {
                    alert('회원가입이 완료되었습니다.');
                    location.href = '/login/user';
                } else {
                    alert(resp.data);
                }
            }).fail(function (error) {
                alert('서버와의 통신 중 오류가 발생했습니다.');
                console.error('Error:', error);
            });
        }
    };

    $(function () {
        signup.init();
    });
</script>

<div class="signup-container">
    <form id="user_add_form" enctype="multipart/form-data">
        <!-- 프로필 섹션 -->
        <div class="form-section">
            <h2 class="section-title">프로필 이미지</h2>
            <div class="profile-preview-container">
                <label for="profile">
                    <img id="profilePreview" src="/images/default-profile.jpg" alt="프로필 이미지 미리보기"/>
                </label>
                <input type="file" id="profile" name="userProfileFile" accept="image/*" hidden="hidden"/>
            </div>
            <small id="profileMessage" class="form-text text-muted">이미지를 클릭해 프로필 사진을 업로드하세요.</small>
        </div>

        <!-- 주소 정보 섹션 -->
        <div class="form-section">
            <h2 class="section-title">주소 정보</h2>
            <div class="form-group">
                <label for="zipcode">우편번호</label>
                <div class="input-group">
                    <input type="text" class="form-control" id="zipcode" name="userZipcode" placeholder="우편번호" readonly required>
                    <button type="button" id="zipcodeBtn">우편번호 검색</button>
                </div>
            </div>
            <div class="form-group">
                <label for="streetAddr">기본 주소</label>
                <input type="text" class="form-control" id="streetAddr" name="userStreetAddr" placeholder="기본 주소" readonly required>
            </div>
            <div class="form-group">
                <label for="detailAddr2">참고 항목</label>
                <input type="text" class="form-control" id="detailAddr2" name="userDetailAddr2" placeholder="참고 항목" readonly>
            </div>
            <div class="form-group">
                <label for="detailAddr1">상세 주소</label>
                <input type="text" class="form-control" id="detailAddr1" name="userDetailAddr1" placeholder="상세 주소를 입력하세요" required>
            </div>
        </div>

        <button type="button" id="btn_add">회원가입 완료</button>
    </form>
</div>
