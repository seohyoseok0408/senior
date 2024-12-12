<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="modal fade" id="messageModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title">쪽지함</h2>
            </div>
            <div class="modal-body">
                <div id="messageListContainer">
                    <ul class="list-group">
                        <!-- 리스트 헤더 -->
                        <li class="list-group-item d-flex justify-content-between font-weight-bold">
                            <span>제목</span>
                            <span>날짜</span>
                        </li>
                    </ul>
                    <ul class="list-group" id="messageList">
                        <!-- 메시지 리스트 항목이 동적으로 추가됩니다 -->
                    </ul>
                </div>
                <!-- 메시지 디테일 -->
                <div id="messageDetailContainer" class="d-none">
                    <h4 id="detailTitle" class="font-weight-bold"></h4>
                    <p id="detailContent" class="mt-3"></p>
                    <button id="backToList" class="btn btn-secondary mt-3">목록으로</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        // 메시지 리스트 로드
        function loadMessages() {
            $.ajax({
                url: '/api/messages/list',
                method: 'GET',
                dataType: 'json',
                success: function (messages) {
                    const messageList = $('#messageList'); // 리스트 요소 선택
                    messageList.empty(); // 기존 항목 제거

                    messages.forEach(message => {
                        let title = message.title;
                        let createdAt = formatDate(message.createdAt);
                        const fontWeight = message.isRead ? "font-weight-normal" : "font-weight-bold";

                        const listItem = `
                        <li class="list-group-item d-flex justify-content-between \${fontWeight}"  data-id="\${message.messageId}">
                            <span>\${title}</span>
                            <span>\${createdAt}<span>
                        </li>`;
                        messageList.append(listItem);
                    });
                },
                error: function (error) {
                    console.error('Failed to load messages:', error);
                }
            });
        }

        // 메시지 디테일 로드
        function loadMessageDetail(messageId) {
            $.ajax({
                url: `/api/messages/detail?messageId=\${messageId}`,
                method: 'GET',
                success: function (message) {
                    // 디테일 뷰 데이터 설정
                    $('#detailTitle').text(message.title);
                    $('#detailContent').text(message.content);

                    // 리스트 숨기고 디테일 보여주기
                    $('#messageListContainer').addClass('d-none');
                    $('#messageDetailContainer').removeClass('d-none');

                    console.log("here", message.isRead);
                    if (!message.isRead) {
                        markMessageAsRead(messageId);
                    }
                },
                error: function (error) {
                    console.error('Failed to load message detail:', error);
                }
            });
        }


        // 날짜 포맷팅 함수
        function formatDate(dateString) {
            if (!dateString) return "알 수 없음";
            const date = new Date(dateString);
            const options = {
                month: '2-digit',
                day: '2-digit',
                hour: '2-digit',
                minute: '2-digit',
                hour12: true
            };
            const formattedDate = new Intl.DateTimeFormat('ko-KR', options).format(date);
            return formattedDate.replace('AM', '오전').replace('PM', '오후');
        }

        // 메시지 읽음 처리 API 호출
        function markMessageAsRead(messageId) {
            console.log(`Marking message \${messageId} as read...`);
            $.ajax({
                url: `/api/messages/mark-as-read?messageId=\${messageId}`,
                method: 'POST',
                success: function () {
                    console.log(`Message ${messageId} marked as read.`);
                    updateUnreadMessageCount(); // 읽지 않은 메시지 개수 업데이트
                },
                error: function (error) {
                    console.error('Failed to mark message as read:', error);
                }
            });
        }

        // 읽지 않은 메시지 개수 업데이트
        function updateUnreadMessageCount() {
            $.ajax({
                url: '/api/messages/unread-count',
                method: 'GET',
                success: function (count) {
                    $('#unreadMessageCount').text(count > 0 ? count : ''); // 헤더에 읽지 않은 메시지 표시
                },
                error: function (error) {
                    console.error('Failed to fetch unread message count:', error);
                }
            });
        }


        // 모달이 열릴 때 메시지 리스트 로드
        $('#messageModal').on('show.bs.modal', function () {
            loadMessages();
        });

        // 메시지 리스트 항목 클릭 이벤트
        $('#messageList').on('click', '.list-group-item', function () {
            const messageId = $(this).data('id');
            console.log('Message ID:', messageId);
            loadMessageDetail(messageId);
        });

        // "목록으로" 버튼 클릭 이벤트
        $('#backToList').on('click', function () {
            $('#messageDetailContainer').addClass('d-none');
            $('#messageListContainer').removeClass('d-none');
            loadMessages();
        });

        // 모달이 열릴 때 메시지 리스트 로드
        $('#messageModal').on('show.bs.modal', function () {
            loadMessages();
        });
        updateUnreadMessageCount();
    });
</script>
