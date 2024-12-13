<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<style>
  tbody tr td {
    color: black;
    font-size: 10px;
  }
  tbody tr:hover td {
    color: #3043c7;
  }
</style>

<div class="content-body">
  <div class="container-fluid">
    <h1>채팅 리스트</h1>
    <div class="col-12">
      <div class="card">
        <div class="card-body">
          <div class="table-responsive">
            <table id="example" class="display" style="min-width: 845px">
              <thead>
              <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Tel</th>
                <th>Email</th>
                <th>Name</th>
                <th>Zipcode</th>
                <th>Street</th>
                <th>Address2</th>
                <th>Address3</th>
                <th>Status</th>
              </tr>
              </thead>
              <tbody>
              <!-- 데이터 행들 -->
              <c:forEach var="user" items="${userList}">
                <tr style="cursor: pointer;"
                    onclick="window.location.href='websocket?userId=${user.userId}'">
                  <td>${user.userId}</td>
                  <td>${user.userUsername}</td>
                  <td>${user.userTel}</td>
                  <td>${user.userEmail}</td>
                  <td>${user.userName}</td>
                  <td>${user.userZipcode}</td>
                  <td>${user.userStreetAddr}</td>
                  <td>${user.userDetailAddr1}</td>
                  <td>${user.userDetailAddr2}</td>
                  <td>${user.userStatus}</td>
                </tr>
              </c:forEach>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="./vendor/global/global.min.js"></script>
<script src="./js/quixnav-init.js"></script>
<script src="./js/custom.min.js"></script>
<script src="./vendor/datatables/js/jquery.dataTables.min.js"></script>
<script src="./js/plugins-init/datatables.init.js"></script>
