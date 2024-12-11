
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    #all {
        width: 400px;
        height: 200px;
        overflow: auto;
        border: 2px solid red;
    }

    #me {
        width: 400px;
        height: 200px;
        overflow: auto;
        border: 2px solid blue;
    }

    #to {
        width: 400px;
        height: 400px;
        overflow: auto;
        border: 2px solid green;
    }
</style>
<div class="col-sm-10">
    <h2>ChatBot Page</h2>
    <div class="col-sm-5">
        <h1 id="login_id">${sessionScope.principal}</h1>
        <H1 id="status">Status</H1>
        <button id="connect">Connect</button>
        <button id="disconnect">Disconnect</button>


        <input type="text" id="totext"><button id="sendto">Send</button>
        <div id="to"></div>

    </div>

</div>
<script src="/js/chatbot.js"></script>