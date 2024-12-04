let chatbtn = {
    init: function () {
        // 사용자 ID 가져오기
        const principalElement = document.getElementById("principal");
        const principal = principalElement ? principalElement.innerText.trim() : "Guest";

        // 채팅 버튼 생성
        const scrollBtn2 = document.createElement("button");
        scrollBtn2.innerHTML = "1:1";
        scrollBtn2.setAttribute("id", "scroll-btn2");
        document.body.appendChild(scrollBtn2);
        scrollBtn2.classList.add("show");

        // 채팅 모달 생성
        const chatModal = document.createElement("div");
        chatModal.setAttribute("id", "chat-modal");
        chatModal.style.display = "none"; // 초기 숨김 처리
        chatModal.innerHTML = `
            <div id="chat-modal-header">
                Chat
                <span id="chat-modal-close">×</span>
            </div>
            <div id="chat-modal-body">
                <h1 id="adm_id">${principal}</h1>
                <h1 id="status">Disconnected</h1>
                <div id="chat-box" style="border: 1px solid #ccc; padding: 10px; height: 200px; overflow-y: auto;"></div>
                <input type="text" id="totext" placeholder="Type your message here" style="width: 80%;">
                <button id="sendto">Send</button>
            </div>`;
        document.body.appendChild(chatModal);

        // 버튼 클릭 시 모달 표시
        scrollBtn2.addEventListener("click", function () {
            chatModal.style.display = "block";
            websocket.init();
        });

        // 모달 닫기 버튼
        const closeButton = document.getElementById("chat-modal-close");
        if (closeButton) {
            closeButton.addEventListener("click", function () {
                chatModal.style.display = "none";
            });
        }
    }
};

let websocket = {
    id: "",
    stompClient: null,
    init: function () {
        this.id = document.getElementById("adm_id").innerText.trim();

        // 메시지 전송 및 WebSocket 연결 처리
        document.getElementById("sendto").addEventListener("click", () => {
            const message = document.getElementById("totext").value;
            if (message) {
                const msg = JSON.stringify({
                    sendid: this.id,
                    receiveid: "0", // Admin ID
                    content1: message,
                });
                this.stompClient.send("/receiveto", {}, msg);
                this.addMessageToChatBox(this.id, message);
                document.getElementById("totext").value = ""; // 입력창 비우기
            }
        });

        this.connect();
    },
    connect: function () {
        const socket = new SockJS("/signaling");
        this.stompClient = Stomp.over(socket);

        this.stompClient.connect({}, (frame) => {
            this.setConnected(true);

            // 개인 메시지 수신
            this.stompClient.subscribe(`/send/to/${this.id}`, (msg) => {
                const message = JSON.parse(msg.body);
                this.addMessageToChatBox(message.sendid, message.content1);
            });

            // 공용 메시지 수신
            this.stompClient.subscribe("/send/to/0", (msg) => {
                const message = JSON.parse(msg.body);
                this.addMessageToChatBox(message.sendid, message.content1);
            });
        }, (error) => {
            console.error("WebSocket Connection Error:", error);
            this.setConnected(false);
        });
    },
    addMessageToChatBox: function (sender, message) {
        const chatBox = document.getElementById("chat-box");
        const newMessage = document.createElement("div");
        newMessage.innerHTML = `<b>${sender}:</b> ${message}`;
        chatBox.appendChild(newMessage);
        chatBox.scrollTop = chatBox.scrollHeight; // 스크롤 자동 내리기
    },
    setConnected: function (connected) {
        const statusElement = document.getElementById("status");
        if (statusElement) {
            statusElement.innerText = connected ? "Connected" : "Disconnected";
        }
    }
};

// DOM 로드 후 초기화
document.addEventListener("DOMContentLoaded", function () {
    chatbtn.init();
});
