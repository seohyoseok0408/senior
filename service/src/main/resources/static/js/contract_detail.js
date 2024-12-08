let index = {
    init: function () {
        $("#btn-approve").on("click", () => {
            this.approveContract();
        });
        this.initKakaoMap();
    },
    approveContract: function () {
        let contractData = {
            contractId: $("#contractId").val(),
            contractPrice: $("#contractPrice").val(),
        };
        console.log(contractData);
        if (!contractData.contractPrice) {
            alert("계약 금액을 입력해주세요.");
            return;
        }
        $.ajax({
            type: "PUT",
            url: "/api/contract",
            data: JSON.stringify(contractData),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
        }).done(function (resp) {
            alert("계약이 승인되었습니다.");
            location.href = "/careworker/contracts";
        }).fail(function (error) {
            alert(JSON.stringify(error));
        });
    },
    initKakaoMap: function () {
        const careworkerLat = parseFloat($("#map").data("cw-lat"));
        const careworkerLng = parseFloat($("#map").data("cw-lng"));
        const seniorLat = parseFloat($("#map").data("sr-lat"));
        const seniorLng = parseFloat($("#map").data("sr-lng"));

        kakao.maps.load(() => {
            const mapContainer = document.getElementById('map'); // 지도 컨테이너
            const centerPosition = new kakao.maps.LatLng(careworkerLat, careworkerLng);

            const mapOption = {
                center: centerPosition,
                level: 5 // 확대 레벨
            };

            const map = new kakao.maps.Map(mapContainer, mapOption);

            // 보호사 마커 및 커스텀 오버레이 설정
            const careworkerMarkerImage = new kakao.maps.MarkerImage(
                "../../images/caregiver.png",
                new kakao.maps.Size(32, 32)
            );

            const careworkerMarker = new kakao.maps.Marker({
                position: centerPosition,
                map: map,
                image: careworkerMarkerImage
            });

            const careworkerOverlayContent = `
                <div style="
                    background: #ffffff; 
                    border: 2px solid #ffffff; 
                    border-radius: 10px; 
                    padding: 3px; 
                    font-size: 12px; 
                    text-align: center; 
                    box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
                    <strong style="color: black;">내 위치</strong>
                </div>
            `;

            const careworkerOverlay = new kakao.maps.CustomOverlay({
                position: centerPosition,
                content: careworkerOverlayContent,
                yAnchor: 2.2 // 마커 바로 위에 위치
            });

            careworkerOverlay.setMap(map);

            // 시니어 마커 및 커스텀 오버레이 설정
            const seniorMarkerImage = new kakao.maps.MarkerImage(
                "../../images/seniormap.png",
                new kakao.maps.Size(32, 32)
            );

            const seniorMarker = new kakao.maps.Marker({
                position: new kakao.maps.LatLng(seniorLat, seniorLng),
                map: map,
                image: seniorMarkerImage
            });

            const seniorOverlayContent = `
                <div style="
                    background: #ffffff; 
                    border: 2px solid #ffffff; 
                    border-radius: 10px; 
                    padding: 3px; 
                    font-size: 12px; 
                    text-align: center; 
                    box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
                    <strong style="color: black;">시니어 위치</strong>
                </div>
            `;

            const seniorOverlay = new kakao.maps.CustomOverlay({
                position: new kakao.maps.LatLng(seniorLat, seniorLng),
                content: seniorOverlayContent,
                yAnchor: 2.2 // 마커 바로 위에 위치
            });

            seniorOverlay.setMap(map);

            // 선(Polyline) 그리기
            const linePath = [
                new kakao.maps.LatLng(careworkerLat, careworkerLng),
                new kakao.maps.LatLng(seniorLat, seniorLng)
            ];

            const polyline = new kakao.maps.Polyline({
                path: linePath,
                strokeWeight: 5,
                strokeColor: '#FFAE00',
                strokeOpacity: 0.8,
                strokeStyle: 'dashed'
            });

            polyline.setMap(map);
        });
    }
};

index.init();
