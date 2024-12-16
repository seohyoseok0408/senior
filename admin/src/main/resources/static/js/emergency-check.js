$(document).ready(function () {
    let isUserInteracted = false; // 사용자가 상호작용했는지 여부
    let previousEmergencyStatus = false; // 이전 비상 상태

    // 사용자가 페이지와 상호작용했는지 확인
    $(document).on('click keydown', function () {
        isUserInteracted = true;
    });

    function checkEmergency() {
        fetch('/iot/emergency-check')
            .then(response => response.json())
            .then(data => {
                const isEmergency = data.isEmergency;

                // 비상 상태가 이전 상태와 다를 때만 실행
                if (isEmergency !== previousEmergencyStatus) {
                    previousEmergencyStatus = isEmergency;

                    if (isEmergency) {
                        const { seniorId, systolicBP, diastolicBP, heartRate, temperature } = data;

                        if (isUserInteracted) {
                            playEmergencySound(); // 사용자 상호작용 후에만 소리 재생
                        }

                        // 경고창 메시지
                        const message = `
                            [비상 상황 발생]
                            시니어 ID: ${seniorId}
                            심박수: ${heartRate} BPM
                            수축기 혈압: ${systolicBP} mmHg
                            이완기 혈압: ${diastolicBP} mmHg
                            체온: ${temperature}°C
                            즉시 조치가 필요합니다!
                        `;
                        alert(message);
                    } else {
                        console.log("비상 상황 해제됨.");
                    }
                }
            })
            .catch(error => console.error('Error checking emergency:', error));
    }

    function playEmergencySound() {
        const sound = document.getElementById('emergencySound');
        if (sound && isUserInteracted) { // 사용자가 상호작용한 경우에만 재생
            sound.currentTime = 0; // 처음부터 재생
            sound.play()
                .then(() => {
                    // 2초 후 소리 중지
                    setTimeout(() => sound.pause(), 2000);
                })
                .catch(error => console.error('Error playing sound:', error));
        } else {
            console.warn('Sound playback blocked by browser due to no user interaction.');
        }
    }

    // 1초마다 비상 상황 확인
    setInterval(checkEmergency, 1500);
});
