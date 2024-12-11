let markers = [];
let currentInfowindow = null; // 현재 열려 있는 InfoWindow를 저장할 변수
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
        const code = senior.dataset.code;
        const image = senior.dataset.profile;
        addMarker(lat, lng, name, image, code);
    });
}

// 중앙 마커 추가 함수
function addCenterMarker(lat, lng, imagePath) {
    var content = `
        <div class="custom-overlay">
            <img src="${imagePath}" style="width:32px; height:32px; border-radius:50%;" />
        </div>`;
    var overlay = new kakao.maps.CustomOverlay({
        position: new kakao.maps.LatLng(lat, lng),
        content: content
    });
    overlay.setMap(map);
}

function addMarker(lat, lng, name, image, code) {
    var imgSrc = "../../images/seniormap.png";
    var imageSize = new kakao.maps.Size(32, 32);

    var seniorMarkerImage = new kakao.maps.MarkerImage(
        imgSrc, imageSize
    );

    var seniorMarker = new kakao.maps.Marker({
        position: new kakao.maps.LatLng(lat, lng),
        map: map,
        image: seniorMarkerImage
    });

    seniorMarker.setMap(map);
    markers.push(seniorMarker);

    const content = `
        <div style="
            width: 250px; 
            padding: 15px; 
            border-radius: 15px; 
            box-shadow: 0px 4px 6px rgba(0,0,0,0.1); 
            text-align: center; 
            font-family: Arial, sans-serif;
            position: relative;">
             <button onclick="closeInfoWindow()" 
                    style="
                        position: absolute;
                        top: 5px;
                        right: 5px;
                        border: none;
                        background: #ffffff;
                        font-size: 18px;
                        cursor: pointer;
                        color: #333;">
                    ×
                </button>
            <img src="../imgs/senior/${image}" 
                alt="Profile" 
                style="width: 80px; height: 80px; border-radius: 50%; margin-bottom: 10px; border: 2px solid #40c057;" />
            <h3 style="margin: 10px 0; font-size: 18px; color: #333;">성함: ${name}</h3>
            <p style="font-size: 13px; color: #f08c00; margin-bottom: 15px;">건강 상태: 양호</p>
            <button onclick="window.location.href='/careworker/seniors/detail?contractId=${code}'" 
                style="
                    padding: 8px 15px; 
                    background-color: #40c057; 
                    color: white; 
                    border: none; 
                    border-radius: 5px; 
                    cursor: pointer; 
                    font-size: 14px;">
                자세히 보기
            </button>
        </div>`;

    const infowindow = new kakao.maps.InfoWindow({
        content: content,
    });

    kakao.maps.event.addListener(seniorMarker, 'click', () => {
        if (currentInfowindow) {
            currentInfowindow.close(); // 이전 InfoWindow 닫기
        }
        infowindow.open(map, seniorMarker);
        currentInfowindow = infowindow; // 현재 열려 있는 InfoWindow 저장
    });
}

// InfoWindow 닫기 함수
function closeInfoWindow() {
    if (currentInfowindow) {
        currentInfowindow.close();
        currentInfowindow = null; // 변수 초기화
    }
}

// 초기화 호출
initMap();
