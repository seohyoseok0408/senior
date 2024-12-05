<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap');

    .ws-container {
        font-family: 'Noto Sans KR', sans-serif;
        max-width: 800px;
        margin: 2rem auto;
        background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
        border-radius: 20px;
        box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
        overflow: hidden;
    }

    .ws-header {
        background: linear-gradient(60deg, #2c786c 0%, #37a794 100%);
        padding: 1.5rem;
        color: white;
    }

    .ws-title {
        font-size: 1.5rem;
        font-weight: 700;
        margin: 0;
        color: white;
    }

    .ws-subtitle {
        font-size: 1rem;
        color: rgba(255, 255, 255, 0.8);
        margin: 0.5rem 0 0;
    }

    .ws-content {
        padding: 2rem;
    }

    .ws-status-container {
        display: flex;
        align-items: center;
        gap: 1rem;
        margin-bottom: 1.5rem;
        background: rgba(255, 255, 255, 0.9);
        padding: 1rem;
        border-radius: 10px;
    }

    .ws-user-id {
        font-size: 1.2rem;
        font-weight: 500;
        color: #2c786c;
    }

    .ws-status {
        font-weight: 500;
        padding: 0.5rem 1rem;
        border-radius: 20px;
        background: #e0f2f1;
        color: #2c786c;
    }

    .ws-controls {
        display: flex;
        gap: 1rem;
        margin-bottom: 2rem;
    }

    .ws-btn {
        padding: 0.75rem 1.5rem;
        border: none;
        border-radius: 25px;
        font-size: 1rem;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.3s ease;
        background: #2c786c;
        color: white;
    }

    .ws-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(44, 120, 108, 0.3);
    }

    .ws-btn.disconnect {
        background: #e74c3c;
    }

    .ws-chat-container {
        margin-top: 2rem;
    }

    .ws-input-group {
        display: flex;
        gap: 1rem;
        margin-bottom: 1rem;
    }

    .ws-input {
        flex: 1;
        padding: 0.75rem 1rem;
        border: 2px solid rgba(44, 120, 108, 0.2);
        border-radius: 10px;
        font-size: 1rem;
        transition: all 0.3s ease;
    }

    .ws-input:focus {
        outline: none;
        border-color: #2c786c;
        box-shadow: 0 0 0 3px rgba(44, 120, 108, 0.1);
    }

    .ws-send-btn {
        padding: 0.75rem 2rem;
        border: none;
        border-radius: 10px;
        background: #f39c12;
        color: white;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    .ws-send-btn:hover {
        background: #e67e22;
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(243, 156, 18, 0.3);
    }

    .ws-messages {
        height: 400px;
        overflow-y: auto;
        background: white;
        border-radius: 10px;
        padding: 1rem;
        box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .ws-messages h4 {
        margin: 0.5rem 0;
        padding: 0.75rem 1rem;
        background: #f8f9fa;
        border-radius: 8px;
        font-size: 1rem;
        line-height: 1.4;
        color: #333;
    }

    .ws-messages h4:first-child {
        background: #e0f2f1;
        color: #2c786c;
    }

    /* Scrollbar Styling */
    .ws-messages::-webkit-scrollbar {
        width: 8px;
    }

    .ws-messages::-webkit-scrollbar-track {
        background: #f1f1f1;
        border-radius: 4px;
    }

    .ws-messages::-webkit-scrollbar-thumb {
        background: #2c786c;
        border-radius: 4px;
    }

    .ws-messages::-webkit-scrollbar-thumb:hover {
        background: #37a794;
    }
</style>

<div class="ws-container">
    <header class="ws-header">
        <h1 class="ws-title">실시간 채팅</h1>
    </header>

    <div class="ws-content">
        <div class="ws-status-container">
            <h1 class="ws-user-id" id="adm_id">${sessionScope.principal}</h1>
            <span class="ws-status" id="status">연결 끊김</span>
        </div>

        <div class="ws-controls">
            <button id="connect" class="ws-btn">연결하기</button>
            <button id="disconnect" class="ws-btn disconnect">연결 끊기</button>
        </div>

        <div class="ws-chat-container">
            <div class="ws-input-group">
                <input type="text" id="totext" class="ws-input" placeholder="메시지를 입력하세요...">
                <button id="sendto" class="ws-send-btn">보내기</button>
            </div>
            <div class="ws-messages" id="to"></div>
        </div>
    </div>
</div>

<script>
    let websocket = {
        id:'',
        stompClient:null,
        init:function(){
            this.id = $('#adm_id').text();
            $('#connect').click(()=>{
                this.connect();
            });
            $('#disconnect').click(()=>{
                this.disconnect();
            });
            $('#sendto').click(()=>{
                var msg = JSON.stringify({
                    'sendid' : this.id,
                    'receiveid' : 0,
                    'content1' : $('#totext').val()
                });
                this.stompClient.send('/receiveto', {}, msg);
                $('#totext').val('');  // 메시지 전송 후 입력 필드 비우기
            });
            // Enter 키로 메시지 전송
            $('#totext').keypress((e) => {
                if(e.which == 13) {
                    $('#sendto').click();
                }
            });
        },
        connect:function(){
            let sid = this.id;
            let socket = new SockJS('${serverurl}/ws');
            this.stompClient = Stomp.over(socket);

            this.stompClient.connect({}, function(frame) {
                websocket.setConnected(true);
                console.log('연결됨: ' + frame);
                this.subscribe('/send/to/'+sid, function(msg) {
                    $("#to").prepend(
                        "<h4>" + JSON.parse(msg.body).sendid +": "+
                        JSON.parse(msg.body).content1
                        + "</h4>");
                });
                this.subscribe('/send/to/0', function(msg) {
                    $("#to").prepend(
                        "<h4>" + JSON.parse(msg.body).sendid +": "+
                        JSON.parse(msg.body).content1
                        + "</h4>");
                });
            });
        },
        disconnect:function(){
            if (this.stompClient !== null) {
                this.stompClient.disconnect();
            }
            websocket.setConnected(false);
            console.log("연결 끊김");
        },
        setConnected:function(connected){
            if (connected) {
                $("#status").text("연결됨");
            } else {
                $("#status").text("연결 끊김");
            }
        }
    };
    $(function(){
        websocket.init();
    });
</script>