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
            contractStartDate: $("#contractStartDate").val(),
            contractEndDate: $("#contractEndDate").val(),
            contractPrice: $("#contractPrice").val(),
        };
        console.log(contractData);
        if (!contractData.contractStartDate || !contractData.contractEndDate || !contractData.contractPrice) {
            alert("모든 필드를 입력해주세요.");
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
            alert(JSON.stringify(error))
        })
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

            // 보호사 마커
            const careworkerMarker = new kakao.maps.Marker({
                position: centerPosition,
                map: map,
                title: "보호사 위치"
            });

            const careworkerInfo = new kakao.maps.InfoWindow({
                content: '<div style="padding:5px;">내 위치</div>'
            });
            careworkerInfo.open(map, careworkerMarker);

            // 시니어 마커
            const seniorMarker = new kakao.maps.Marker({
                position: new kakao.maps.LatLng(seniorLat, seniorLng),
                map: map,
                title: "시니어 위치"
            });

            const seniorInfo = new kakao.maps.InfoWindow({
                content: '<div style="padding:5px;">시니어 위치</div>'
            });
            seniorInfo.open(map, seniorMarker);

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
}

index.init();
