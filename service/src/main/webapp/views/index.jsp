<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!-- Include Header -->
<%@ include file="layout/header.jsp" %>

<style>
    #scroll-btn2 {
        opacity: 0;
        width: 50px;
        height: 50px;
        color: #fff;
        background-color: #ef476f;
        position: fixed;
        bottom: 5%;
        right: 10%;
        border: 2px solid #fff;
        border-radius: 50%;
        font: bold 10px monospace;
        cursor: pointer;
        transition: opacity 2s ease, transform 2s ease;
    }

    #scroll-btn2.show {
        opacity: 1;
        transition: opacity 5s ease, transform 5s ease;
    }

    #chat-modal {
        display: none;
        position: fixed;
        bottom: 10%;
        right: 5%;
        width: 300px;
        height: 400px;
        border: 2px solid #ccc;
        border-radius: 10px;
        background-color: #f9f9f9;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        z-index: 1000;
        overflow: hidden;
        animation: fadeIn 0.3s ease;
    }

    #chat-modal-header {
        background-color: #ef476f;
        color: #fff;
        padding: 10px;
        text-align: center;
        font-weight: bold;
        position: relative;
    }

    #chat-modal-body {
        padding: 10px;
        overflow-y: auto;
        height: calc(100% - 50px);
        font-family: Arial, sans-serif;
        font-size: 14px;
    }

    #chat-modal-close {
        position: absolute;
        top: 10px;
        right: 10px;
        cursor: pointer;
        color: #fff;
        font-size: 18px;
    }

    @keyframes fadeIn {
        from {
            opacity: 0;
            transform: scale(0.9);
        }
        to {
            opacity: 1;
            transform: scale(1);
        }
    }

</style>

<!-- Include Center Content Section -->
<c:choose>
    <c:when test="${center == null}">
        <jsp:include page="center.jsp"/>
    </c:when>
    <c:otherwise>
        <jsp:include page="${center}.jsp"/>
    </c:otherwise>
</c:choose>
<div id="principal" style="display: none;">${sessionScope.principal}</div>
<script src="/js/index.js"></script>
<!-- Include Footer -->
<%@ include file="layout/footer.jsp" %>