let chatbtn = {
    init: function () {
        const principalElement = document.getElementById("principal");
        const principal = principalElement ? principalElement.innerText.trim() : "손님";
        if (document.getElementById("login_id")) {
            document.getElementById("login_id").innerText = principal;
        }
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
            console.log("WebSocket 초기화 시작");
            if (!websocket.stompClient || !websocket.stompClient.connected) {
                websocket.init();
            }
        });


        const closeButton = document.getElementById("chat-modal-close");
        if (closeButton) {
            closeButton.addEventListener("click", function () {
                chatModal.style.display = "none";
            });
        }

        const chatbotBtn = document.createElement("button");
        chatbotBtn.style.zIndex = 10;
        chatbotBtn.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 3h18a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2z"></path></svg>';
        chatbotBtn.setAttribute("id", "chatbot-btn");
        chatbotBtn.setAttribute("title", "Chatbot 시작");
        document.body.appendChild(chatbotBtn);
        chatbotBtn.classList.add("show");

        const chatbotModal = document.createElement("div");
        chatbotModal.setAttribute("id", "chatbot-modal");
        chatbotModal.style.display = "none";
        chatbotModal.style.zIndex = 10;
        chatbotModal.innerHTML = `
            <div id="chatbot-modal-header">
                Chatbot
                <span id="chatbot-modal-close">×</span>
            </div>
            <div id="chatbot-modal-body">
                <h3 id="login_id" hidden="hidden">${principal}</h3>
                <p id="chatbot-status">연결 끊김</p>
                <div id="chatbot-box"></div>
                <input type="text" id="chatbot-text" placeholder="메시지를 입력하세요">
                <button id="chatbot-send">전송</button>
            </div>`;
        document.body.appendChild(chatbotModal);

        chatbotBtn.addEventListener("click", function () {
            chatbotModal.style.display = "block";
            console.log("Chatbot WebSocket 초기화 시작");
            if (!chatbotWebSocket.stompClient || !chatbotWebSocket.stompClient.connected) {
                chatbotWebSocket.init();
            }
        });




        const chatbotCloseButton = document.getElementById("chatbot-modal-close");
        if (chatbotCloseButton) {
            chatbotCloseButton.addEventListener("click", function () {
                chatbotModal.style.display = "none";
                console.log(document.getElementById("login_id").innerText);
            });
        }
    }
};

let websocket = {
    id: "",
    stompClient: null,
    language: "",
    init: function () {
        this.id = document.getElementById("adm_id").innerText.trim();
        this.language = navigator.language;
        console.log("llll", this.language)
        this.connect();

        document.getElementById("sendto").onclick = () => {
            const messageContent = document.getElementById("totext").value.trim();
            const userLanguage = this.language.startsWith('ko') ? 'ko' : 'en'; // 브라우저 언어 확인
            if (messageContent) {
                const msg = JSON.stringify({
                    sendid: this.id,
                    receiveid: "0",
                    content1: messageContent,
                    role: "USER",
                    language: userLanguage   // 언어 설정
                });

                this.stompClient.send("/receiveto", {}, msg);
                document.getElementById("totext").value = "";
            }
        };


        document.getElementById("totext").addEventListener("keypress", (e) => {
            if (e.key === "Enter") {
                document.getElementById("sendto").click();
            }
        });
    },
    connect: function () {
        let socket = new SockJS(serverurl + '/ws');
        this.stompClient = Stomp.over(socket);

        this.stompClient.connect({}, (frame) => {
            console.log("연결됨: " + frame);
            this.setConnected(true);

            this.stompClient.subscribe(`/send/to/${this.id}`, (msg) => {
                const message = JSON.parse(msg.body);
                console.log("메시지 수신:", message); // 로그 출력
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

let chatbotWebSocket = {
    id: "",
    stompClient: null,
    init: function () {
        this.id = document.getElementById("login_id").innerText.trim();
        console.log("WebSocket 구독 ID:", this.id);
        this.connect();

        document.getElementById("chatbot-send").addEventListener("click", () => {
            const messageContent = document.getElementById("chatbot-text").value.trim();
            if (messageContent) {
                const msg = JSON.stringify({
                    sendid: this.id,
                    receiveid: "bot",
                    content1: messageContent,
                });

                // 메시지 전송
                this.stompClient.send("/app/sendchatbot", {}, msg);

                // 화면에 "고객님"으로 메시지 추가
                this.addMessageToChatBox("고객님", messageContent);

                document.getElementById("chatbot-text").value = "";
            }
        });

        document.getElementById("chatbot-text").addEventListener("keypress", (e) => {
            if (e.key === "Enter") {
                document.getElementById("chatbot-send").click();
            }
        });
    },

    connect: function () {
        if (this.isConnected) {
            console.log("이미 연결되어 있습니다.");
            return;
        }

        let sid = this.id;
        let socket = new SockJS('/chatbot');
        this.stompClient = Stomp.over(socket);

        this.stompClient.connect({}, (frame) => {
            this.isConnected = true;
            this.setConnected(true);
            console.log('Connected: ' + frame);

            // 사용자 개인 메시지 구독
            this.stompClient.subscribe(`/sendto/${sid}`, (msg) => {
                const message = JSON.parse(msg.body);
                console.log("수신된 사용자 메시지:", message);

                // 화면에 "고객님" 메시지 추가
                this.addMessageToChatBox("챗봇", message.content1);
            });

            // Chatbot 메시지 구독
            this.stompClient.subscribe("/sendto/bot", (msg) => {
                const message = JSON.parse(msg.body);
                console.log("수신된 Chatbot 메시지:", message);

                // 화면에 "Chatbot" 메시지 추가
                this.addMessageToChatBox("Chatbot", message.content1);
            });
        });
    },

    addMessageToChatBox: function (sender, message) {
        const chatBox = document.getElementById("chatbot-box");
        const newMessage = document.createElement("div");

        // 메시지 표시: "고객님" 또는 "Chatbot"
        newMessage.innerHTML = `<strong>${sender}:</strong> ${message}`;
        chatBox.appendChild(newMessage);
        chatBox.scrollTop = chatBox.scrollHeight; // 스크롤 맨 아래로 이동
    },

    setConnected: function (connected) {
        const statusElement = document.getElementById("chatbot-status");
        if (statusElement) {
            statusElement.innerText = connected ? "연결됨" : "연결 끊김";
            statusElement.style.color = connected ? "#4CAF50" : "#f44336";
        }
    }
};
