// 마커를 담을 배열입니다
var markers = [];

// 시니어 중심 좌표
var lat = $('#seniorLat').val();
var lng = $('#seniorLng').val();
var profileImagePath = "../../images/seniormap.png"; // 고정된 이미지 경로

console.log("lat:", lat);
console.log("lng:", lng);

// 지도 설정
var mapContainer = document.getElementById('map');
var mapOption = {
    center: new kakao.maps.LatLng(lat, lng),
    level: 3 // 지도의 확대 레벨
};

// 지도 생성
var map = new kakao.maps.Map(mapContainer, mapOption);

// 장소 검색 객체 생성
var ps = new kakao.maps.services.Places();

// 검색 결과 목록과 마커를 클릭 시 표시할 인포윈도우
var infowindow = new kakao.maps.InfoWindow({
    zIndex: 1,
    boxShadow: '0 2px 6px rgba(0,0,0,0.3)'
});

// 초기 중앙 마커 추가
addCenterMarker(lat, lng, profileImagePath);

// 기본 병원 카테고리 표시
searchPlaces("HP8");

// 병원/약국 버튼 클릭 이벤트 등록
document.getElementById('hospitalBtn').addEventListener('click', function () {
    updateCategory("HP8");
});
document.getElementById('pharmacyBtn').addEventListener('click', function () {
    updateCategory("PM9");
});

// 카테고리 변경 후 검색하는 함수
function updateCategory(category) {
    document.querySelectorAll('#category_wrap button').forEach((btn) => {
        btn.classList.remove('active');
    });

    document.getElementById(category === "HP8" ? 'hospitalBtn' : 'pharmacyBtn').classList.add('active');

    removeMarker();
    searchPlaces(category);
}

// 중앙 마커 추가 함수
function addCenterMarker(lat, lng, imagePath) {
    var content = `
        <div>
            <img src="${imagePath}" style="width:40px; height:40px; border-radius:50%; border: 2px solid #45C65A;" />
        </div>`;
    var overlay = new kakao.maps.CustomOverlay({
        position: new kakao.maps.LatLng(lat, lng),
        content: content
    });
    overlay.setMap(map);
}

// 장소 검색 요청 함수
function searchPlaces(category) {
    removeMarker();
    ps.categorySearch(category, placesSearchCB, {
        location: new kakao.maps.LatLng(lat, lng),
        radius: 5000 // 반경 5km
    });
}

// 장소 검색 결과 콜백 함수
function placesSearchCB(data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {
        displayPlaces(data);
        displayPagination(pagination);
    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
        alert('검색 결과가 존재하지 않습니다.');
    } else if (status === kakao.maps.services.Status.ERROR) {
        alert('검색 결과 중 오류가 발생했습니다.');
    }
}

// 검색 결과 목록 및 마커 표시
function displayPlaces(places) {
    var listEl = document.getElementById('placesList');
    var fragment = document.createDocumentFragment();
    var bounds = new kakao.maps.LatLngBounds();

    removeAllChildNods(listEl);
    removeMarker();

    places.forEach((place, i) => {
        var placePosition = new kakao.maps.LatLng(place.y, place.x);
        var marker = addMarker(placePosition, i);
        var itemEl = getListItem(i, place);

        bounds.extend(placePosition);

        (function(marker, title) {
            kakao.maps.event.addListener(marker, 'mouseover', () => displayInfowindow(marker, title));
            kakao.maps.event.addListener(marker, 'mouseout', () => infowindow.close());
            itemEl.onmouseover = () => displayInfowindow(marker, title);
            itemEl.onmouseout = () => infowindow.close();
        })(marker, place.place_name);

        fragment.appendChild(itemEl);
    });

    listEl.appendChild(fragment);
    map.setBounds(bounds);
}

// 목록 항목 생성 함수
function getListItem(index, place) {
    var el = document.createElement('li');
    el.className = 'item';

    el.innerHTML = `
        <span class="markerbg marker_${index+1}"></span>
        <div class="info">
            <h5>${index+1}. ${place.place_name}</h5>
            ${place.road_address_name ? `<span>${place.road_address_name}</span>` : ''}
            <span class="jibun gray">${place.address_name}</span>
            <span class="tel">${place.phone || '전화번호 없음'}</span>
        </div>`;
    return el;
}

// 마커 생성 함수
function addMarker(position, idx) {
    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png';
    var imageSize = new kakao.maps.Size(36, 37);
    var imgOptions = {
        spriteSize: new kakao.maps.Size(36, 691),
        spriteOrigin: new kakao.maps.Point(0, (idx * 46) + 10),
        offset: new kakao.maps.Point(13, 37)
    };

    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions);
    var marker = new kakao.maps.Marker({
        position: position,
        image: markerImage
    });

    marker.setMap(map);
    markers.push(marker);

    return marker;
}

// 마커 제거 함수
function removeMarker() {
    markers.forEach(marker => marker.setMap(null));
    markers = [];
}

// 페이지네이션 표시
function displayPagination(pagination) {
    var paginationEl = document.getElementById('pagination');
    var fragment = document.createDocumentFragment();

    while (paginationEl.hasChildNodes()) {
        paginationEl.removeChild(paginationEl.lastChild);
    }

    for (var i = 1; i <= pagination.last; i++) {
        var el = document.createElement('a');
        el.href = "#";
        el.innerHTML = i;
        el.className = i === pagination.current ? 'on' : '';

        el.onclick = (function(i) {
            return function() {
                pagination.gotoPage(i);
            }
        })(i);

        fragment.appendChild(el);
    }
    paginationEl.appendChild(fragment);
}

// 인포윈도우 표시
function displayInfowindow(marker, title) {
    var content = `<div style="padding:10px;font-size:14px;font-weight:500;">${title}</div>`;
    infowindow.setContent(content);
    infowindow.open(map, marker);
}

// 목록의 자식 요소 모두 제거
function removeAllChildNods(el) {
    while (el.hasChildNodes()) {
        el.removeChild(el.lastChild);
    }
}