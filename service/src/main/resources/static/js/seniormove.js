// 시니어 중심 좌표
var lat = parseFloat($('#seniorLat').val());
var lng = parseFloat($('#seniorLng').val());
var profileImagePath = "../../images/house.jpg"; // 고정 마커 이미지 경로

console.log("lat:", lat);
console.log("lng:", lng);

var mapContainer = document.getElementById('map');
var mapOption = {
    center: new kakao.maps.LatLng(lat, lng),
    level: 1
};

// 지도 생성
var map = new kakao.maps.Map(mapContainer, mapOption);

// 초기 중앙 마커 추가
addCenterMarker(lat, lng, profileImagePath);

// 시니어 랜덤 이동 마커
var seniorMovingMarker = null; // 단일 마커 객체로 선언
const MIN_STEP_SIZE = 1.5; // 최소 이동 거리 (1.5m)
const MAX_STEP_SIZE = 5;  // 최대 이동 거리 (10m)

// 중앙 마커 추가 함수
function addCenterMarker(lat, lng, imagePath) {
    // 마커 커스텀 오버레이 생성
    var content = `
        <div class="custom-overlay">
            <img src="${imagePath}" style="width:50px; height:50px; border-radius:50%;" />
        </div>
    `;

    var customOverlay = new kakao.maps.CustomOverlay({
        position: new kakao.maps.LatLng(lat, lng),
        content: content,
        map: map
    });

    // 랜덤 이동 마커 업데이트 시작
    setInterval(updateSeniorMovingMarker, 1000); // 1초 간격
}

// 랜덤 이동 좌표 생성 함수 (이동 반경 다양화)
function getWalkingPosition(currentLat, currentLng) {
    const randomStepSize = Math.random() * (MAX_STEP_SIZE - MIN_STEP_SIZE) + MIN_STEP_SIZE; // 랜덤 이동 거리
    const randomAngle = Math.random() * Math.PI * 2; // 랜덤 방향 (0 ~ 360도)
    const deltaLat = randomStepSize * Math.cos(randomAngle) / 111000; // 위도 변위 계산
    const deltaLng = randomStepSize * Math.sin(randomAngle) / (111000 * Math.cos(currentLat * Math.PI / 180)); // 경도 변위 계산
    return {
        lat: currentLat + deltaLat,
        lng: currentLng + deltaLng
    };
}

// 이동 마커 생성 및 위치 업데이트 함수
function updateSeniorMovingMarker() {
    // 새로운 위치 계산
    const randomPosition = getWalkingPosition(lat, lng);

    if (!seniorMovingMarker) {
        // 초기 이동 마커 생성
        var content = `
            <div class="custom-overlay">
                <img src="../../images/seniormove.png" style="width:50px; height:50px; border-radius:50%;" />
            </div>
        `;

        seniorMovingMarker = new kakao.maps.CustomOverlay({
            position: new kakao.maps.LatLng(randomPosition.lat, randomPosition.lng),
            content: content,
            map: map
        });
    } else {
        // 기존 마커 위치 업데이트
        const newLatLng = new kakao.maps.LatLng(randomPosition.lat, randomPosition.lng);
        seniorMovingMarker.setPosition(newLatLng);
    }

    // 현재 위치를 기준으로 다음 이동 기준 좌표 업데이트
    lat = randomPosition.lat;
    lng = randomPosition.lng;
}
