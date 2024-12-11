let websocket = {
    id: '',
    stompClient: null,
    subscription: null,
    isConnected: false,  // 연결 상태 플래그

    init: function () {
        this.id = $('#login_id').text();
        $('#connect').click(() => {
            this.connect();
        });
        $('#disconnect').click(() => {
            this.disconnect();
        });
        $('#sendto').click(() => {
            this.sendMessage();
        });
        $('#totext').keypress((e) => {
            if (e.which == 13) {
                this.sendMessage();
            }
        });
    },

    connect: function () {
        if (this.isConnected) {
            console.log("이미 연결되어 있습니다.");
            return;  // 중복 연결 방지
        }

        let sid = this.id;
        let socket = new SockJS('/chatbot');
        this.stompClient = Stomp.over(socket);

        this.stompClient.connect({}, (frame) => {
            this.isConnected = true;
            this.setConnected(true);
            console.log('Connected: ' + frame);

            this.stompClient.subscribe('/sendto/' + sid, (msg) => {
                const message = JSON.parse(msg.body);
                this.displayMessage(message.sendid, message.content1);
            });
        });
    },

    disconnect: function () {
        if (this.stompClient !== null) {
            this.stompClient.disconnect(() => {
                this.isConnected = false;  // 연결 상태 플래그 초기화
                console.log("Disconnected");
                this.setConnected(false);
            });
        }
    },

    sendMessage: function () {
        if (!this.isConnected) {
            console.log("연결되지 않았습니다.");
            return;
        }

        const messageContent = $('#totext').val();
        if (messageContent.trim() !== "") {
            const msg = JSON.stringify({
                'sendid': this.id,
                'content1': messageContent
            });

            this.stompClient.send('/chatbot/sendchatbot', {}, msg);
            $('#totext').val("");  // 입력 필드 비우기
        }
    },

    displayMessage: function (sender, message) {
        $("#to").prepend(`<h4>${sender}: ${message}</h4>`);
    },

    setConnected: function (connected) {
        const status = connected ? "Connected" : "Disconnected";
        $("#status").text(status);
    }
};

$(function () {
    websocket.init();
});
