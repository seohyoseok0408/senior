let markers = [];
var profileImagePath = "../../images/caregiver.png"; // 고정된 이미지 경로

// 지도 초기화
function initMap() {
    const centerLat = $('#centerLat').val();
    const centerLng = $('#centerLng').val();

    const mapContainer = document.getElementById('map');
    const mapOption = {
        center: new kakao.maps.LatLng(centerLat, centerLng),
        level: 7,
    };

    map = new kakao.maps.Map(mapContainer, mapOption);

    // 현재 시니어의 위치를 중심 마커로 추가
    addCenterMarker(centerLat, centerLng, profileImagePath);

    // 주변 시니어 마커 추가
    const seniors = document.querySelectorAll('.senior');
    seniors.forEach(senior => {
        const lat = parseFloat(senior.dataset.lat);
        const lng = parseFloat(senior.dataset.lng);
        const name = senior.dataset.name;

        addMarker(lat, lng, name);
    });
}

// 중앙 마커 추가 함수
function addCenterMarker(lat, lng, imagePath) {
    var content = `
        <div class="custom-overlay">
            <img src="${imagePath}" style="width:50px; height:50px; border-radius:50%;" />
        </div>`;
    var overlay = new kakao.maps.CustomOverlay({
        position: new kakao.maps.LatLng(lat, lng),
        content: content
    });
    overlay.setMap(map);
}

function addMarker(lat, lng, title) {
    var imgSrc = "../../images/seniormap.png";
    var imageSize = new kakao.maps.Size(32, 32);

    var seniorMarkerImage = new kakao.maps.MarkerImage(
        imgSrc, imageSize
    );

    var seniorMarker = new kakao.maps.Marker({
        position: new kakao.maps.LatLng(lat, lng),
        map: map,
        image: seniorMarkerImage
    })

    seniorMarker.setMap(map);
    markers.push(seniorMarker);

    // 마커 클릭 이벤트로 정보창 표시
    const infowindow = new kakao.maps.InfoWindow({
        content: `<div style="padding:5px;z-index:1;">${title}</div>`,
    });

    kakao.maps.event.addListener(seniorMarker, 'click', () => {
        infowindow.open(map, seniorMarker);
    });
}

// 초기화 호출
initMap();
