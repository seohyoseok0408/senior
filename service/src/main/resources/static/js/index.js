let chatbtn = {
    init: function () {
        const principalElement = document.getElementById("principal");
        const principal = principalElement ? principalElement.innerText.trim() : "손님";

        const scrollBtn2 = document.createElement("button");
        scrollBtn2.style.zIndex = 10;
        scrollBtn2.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path></svg>';
        scrollBtn2.setAttribute("id", "scroll-btn2");
        scrollBtn2.setAttribute("title", "채팅 시작");
        document.body.appendChild(scrollBtn2);
        scrollBtn2.classList.add("show");

        const chatModal = document.createElement("div");
        chatModal.setAttribute("id", "chat-modal");
        chatModal.style.display = "none";
        chatModal.style.zIndex = 10;
        chatModal.innerHTML = `
            <div id="chat-modal-header">
                실시간 채팅
                <span id="chat-modal-close">×</span>
            </div>
            <div id="chat-modal-body">
                <h3 id="adm_id" hidden="hidden">${principal}</h3>
                <p id="status">연결 끊김</p>
                <div id="chat-box"></div>
                <input type="text" id="totext" placeholder="메시지를 입력하세요">
                <button id="sendto">전송</button>
            </div>`;
        document.body.appendChild(chatModal);

        scrollBtn2.addEventListener("click", function () {
            chatModal.style.display = "block";
            websocket.init();
        });

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
        this.connect();

        document.getElementById("sendto").addEventListener("click", () => {
            const messageContent = document.getElementById("totext").value.trim();
            if (messageContent) {
                const msg = JSON.stringify({
                    sendid: this.id,
                    receiveid: "0",
                    content1: messageContent,
                });

                this.stompClient.send("/receiveto", {}, msg);
                document.getElementById("totext").value = "";
            }
        });

        document.getElementById("totext").addEventListener("keypress", (e) => {
            if (e.key === "Enter") {
                document.getElementById("sendto").click();
            }
        });
    },
    connect: function () {
        let socket = new SockJS(serverurl+'/ws');
        this.stompClient = Stomp.over(socket);

        this.stompClient.connect({}, (frame) => {
            console.log("연결됨: " + frame);
            this.setConnected(true);

            this.stompClient.subscribe(`/send/to/${this.id}`, (msg) => {
                const message = JSON.parse(msg.body);
                this.addMessageToChatBoxAdmin(message.sendid, message.content1);
            });

            this.stompClient.subscribe("/send/to/0", (msg) => {
                const message = JSON.parse(msg.body);
                this.addMessageToChatBox(message.sendid, message.content1);
            });
        }, (error) => {
            console.error("WebSocket 연결 오류:", error);
            this.setConnected(false);
        });
    },
    addMessageToChatBox: function (sender, message) {
        const chatBox = document.getElementById("chat-box");
        const newMessage = document.createElement("div");
        newMessage.innerHTML = `<strong>고객님:</strong> ${message}`;
        chatBox.appendChild(newMessage);
        chatBox.scrollTop = chatBox.scrollHeight;
    },
    addMessageToChatBoxAdmin: function (sender, message) {
        const chatBox = document.getElementById("chat-box");
        const newMessage = document.createElement("div");
        newMessage.innerHTML = `<strong>관리자:</strong> ${message}`;
        chatBox.appendChild(newMessage);
        chatBox.scrollTop = chatBox.scrollHeight;
    },
    setConnected: function (connected) {
        const statusElement = document.getElementById("status");
        if (statusElement) {
            statusElement.innerText = connected ? "연결됨" : "연결 끊김";
            statusElement.style.color = connected ? "#4CAF50" : "#f44336";
        }
    }
};

document.addEventListener("DOMContentLoaded", function () {
    chatbtn.init();
});