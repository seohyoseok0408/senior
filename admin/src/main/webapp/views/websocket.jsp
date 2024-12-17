<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');

    :root {
        --primary-color: #6366f1;
        --secondary-color: #4f46e5;
        --background-color: #f9fafb;
        --text-color: #1f2937;
        --light-text-color: #6b7280;
        --border-color: #e5e7eb;
        --success-color: #10b981;
        --error-color: #ef4444;
    }

    body {
        font-family: 'Poppins', sans-serif;
        background-color: var(--background-color);
        color: var(--text-color);
        margin: 0;
        padding: 0;
        line-height: 1.5;
    }

    .content-body {
        padding: 2rem;
    }

    .container-fluid {
        max-width: 1200px;
        margin: 0 auto;
    }

    .h3.mb-2 {
        font-size: 1.875rem;
        font-weight: 700;
        color: var(--primary-color);
        margin-bottom: 1.5rem;
    }

    .card {
        background: #ffffff;
        border-radius: 0.5rem;
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
        overflow: hidden;
    }

    .card-header {
        background: var(--primary-color);
        color: #ffffff;
        padding: 1.25rem;
        font-size: 1.25rem;
        font-weight: 600;
    }

    .card-body {
        padding: 1.5rem;
    }

    .table-responsive {
        overflow-x: auto;
    }

    #adm_id {
        font-size: 1.125rem;
        color: var(--primary-color);
        margin-bottom: 1rem;
        font-weight: 600;
    }

    #status {
        font-size: 0.875rem;
        padding: 0.5rem 1rem;
        border-radius: 9999px;
        display: inline-block;
        margin-bottom: 1rem;
        font-weight: 500;
        transition: all 0.3s ease;
    }

    #status.connected {
        background: var(--success-color);
        color: #ffffff;
    }

    #status.disconnected {
        background: var(--error-color);
        color: #ffffff;
    }

    .btn-group {
        display: flex;
        gap: 1rem;
        margin-bottom: 1.5rem;
    }

    button {
        padding: 0.75rem 1.5rem;
        border: none;
        border-radius: 0.375rem;
        font-size: 0.875rem;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.3s ease;
        text-transform: uppercase;
    }

    #connect {
        background: var(--primary-color);
        color: #ffffff;
    }

    #connect:hover {
        background: var(--secondary-color);
    }

    #disconnect {
        background: var(--error-color);
        color: #ffffff;
    }

    #disconnect:hover {
        opacity: 0.9;
    }

    .chat-section h3 {
        font-size: 1.125rem;
        color: var(--primary-color);
        margin: 1rem 0;
        font-weight: 600;
    }

    .input-group {
        display: flex;
        gap: 0.5rem;
        margin-bottom: 1rem;
    }

    #totext {
        flex: 1;
        padding: 0.75rem;
        border: 1px solid var(--border-color);
        border-radius: 0.375rem;
        font-size: 0.875rem;
        transition: border-color 0.3s ease;
    }

    #totext:focus {
        outline: none;
        border-color: var(--primary-color);
        box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
    }

    #sendto {
        background: var(--primary-color);
        color: #ffffff;
        padding: 0.75rem 1.5rem;
        border-radius: 0.375rem;
    }

    #sendto:hover {
        background: var(--secondary-color);
    }

    #to {
        height: 300px;
        overflow-y: auto;
        border: 1px solid var(--border-color);
        border-radius: 0.375rem;
        padding: 1rem;
        background: #ffffff;
    }

    #to h4 {
        margin: 0.5rem 0;
        padding: 0.75rem;
        background: var(--background-color);
        border-radius: 0.375rem;
        font-size: 0.875rem;
        box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
    }

    #to::-webkit-scrollbar {
        width: 6px;
    }

    #to::-webkit-scrollbar-track {
        background: var(--background-color);
    }

    #to::-webkit-scrollbar-thumb {
        background: var(--primary-color);
        border-radius: 3px;
    }

    #to::-webkit-scrollbar-thumb:hover {
        background: var(--secondary-color);
    }

    @media (max-width: 640px) {
        .content-body {
            padding: 1rem;
        }

        .card-body {
            padding: 1rem;
        }

        .btn-group {
            flex-direction: column;
        }

        button {
            width: 100%;
        }
    }
</style>

<div class="content-body">
    <div class="container-fluid">
        <h1 class="h3 mb-2">실시간 채팅 관리 시스템</h1>

        <div class="card shadow mb-4">
            <div class="card-header">
                <h6 class="m-0 font-weight-bold">관리자 채팅 콘솔</h6>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <div>
                        <h2 id="adm_id">${sessionScope.principal}</h2>
                        <div id="status" class="disconnected">연결 끊김</div>

                        <div class="btn-group">
                            <button id="connect">연결하기</button>
                            <button id="disconnect">연결 끊기</button>
                        </div>

                        <div class="chat-section">
                            <h3>메시지 창</h3>
                            <input type="hidden" id="target" value="${userId}">
                            <div class="input-group">
                                <input type="text" id="totext" placeholder="메시지를 입력하세요...">
                                <button id="sendto">전송</button>
                            </div>
                            <div id="to"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    let websocket = {
        id: '',
        targetId: '',
        stompClient: null,
        init: function () {
            this.id = '0';
            this.targetId = $("#target").val();
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
                if(e.which == 13) {
                    this.sendMessage();
                }
            });
        },
        connect: function () {
            let sid = this.id;
            let targetIdd = this.targetId;
            let socket = new SockJS('${serverurl}/ws');
            this.stompClient = Stomp.over(socket);

            this.stompClient.connect({}, (frame) => {
                this.setConnected(true);
                console.log('연결됨: ' + frame);
                this.stompClient.subscribe('/send/to/' + sid, (msg) => {
                    this.addMessage(JSON.parse(msg.body));
                });
                this.stompClient.subscribe('/send/to/' + targetIdd, (msg) => {
                    this.addMessage(JSON.parse(msg.body));
                });
            }, (error) => {
                console.error('연결 오류:', error);
                this.setConnected(false);
            });
        },
        disconnect: function () {
            if (this.stompClient !== null) {
                this.stompClient.disconnect();
            }
            this.setConnected(false);
            console.log("연결 끊김");
        },
        setConnected: function (connected) {
            if (connected) {
                $("#status").text("연결됨").removeClass("disconnected").addClass("connected");
            } else {
                $("#status").text("연결 끊김").removeClass("connected").addClass("disconnected");
            }
        },
        sendMessage: function() {
            var messageContent = $('#totext').val().trim();
            if (messageContent) {
                var msg = JSON.stringify({
                    'sendid': this.id,
                    'receiveid': $('#target').val(),
                    'content1': messageContent,
                    'role': "ADMIN"
                });
                this.stompClient.send('/receiveto', {}, msg);
                $('#totext').val('');
            }
        },
        addMessage: function(message) {
            $("#to").prepend(
                "<h4>" + message.sendid + ": " + message.content1 + "</h4>"
            );
        }
    };
    $(function () {
        websocket.init();
    });
</script>

