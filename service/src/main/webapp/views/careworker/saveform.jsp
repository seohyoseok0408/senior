<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="container">
  <h1>${senior.seniorName}님의 업무일지 작성</h1>

  <form>
    <div class="form-group">
      <textarea class="form-control summernote" rows="5" id="content"></textarea>
    </div>
    <div class="form-group">
      <label for="visitStartDate">근무 시작 날짜</label>
      <input type="datetime-local" class="form-control" id="visitStartDate">
    </div>
    <div class="form-group">
      <label for="visitEndDate">근무 종료 날짜</label>
      <input type="datetime-local" class="form-control" id="visitEndDate">
    </div>
    <input type="hidden" value="${sessionScope.principal}" id="cwId">
    <input type="hidden" value="${senior.seniorId}" id="seniorId">
  </form>
  <button id="btn-save" class="btn btn-primary">글쓰기완료</button>
</div>
<script src="/js/board.js"></script>