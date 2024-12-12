$(document).ready(function () {
    // 읽지 않은 메시지 개수 업데이트 함수
    function updateUnreadMessageCount() {
        $.ajax({
            url: '/api/messages/unread-count', // 읽지 않은 메시지 개수 API 엔드포인트
            method: 'GET',
            success: function (unreadCount) {
                const unreadBadge = $('#unreadMessageCount'); // 헤더의 읽지 않은 메시지 개수 표시 요소

                console.log('Unread message count:', unreadCount);
                if (unreadCount > 0) {
                    unreadBadge.text(unreadCount).removeClass('d-none'); // 개수를 표시하고 배지를 보이게 함
                } else {
                    unreadBadge.text('').addClass('d-none'); // 개수가 0이면 배지를 숨김
                }
            },
            error: function (error) {
                console.error('Failed to fetch unread message count:', error);
            }
        });
    }

    // 페이지 로드 시 초기 업데이트
    updateUnreadMessageCount();

    // 일정 간격으로 업데이트 (선택 사항)
    setInterval(updateUnreadMessageCount, 60000); // 1분마다 새로고침
});
