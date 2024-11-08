<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    tbody tr td {
        color: black; /* 기본 글자 색상을 검정으로 설정 */
        font-size: 10px; /* 원하는 글자 크기로 조정 */
    }

    tbody tr:hover td {
        color: #3043c7; /* 마우스를 올렸을 때 글자 색상을 파란색으로 설정 */
    }
</style>

<div class="content-body">
    <div class="container-fluid">
        <h1>User List</h1>
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
                                <th>Address1</th>
                                <th>Address2</th>
                                <th>Address3</th>
                                <th>Status</th>
                            </tr>
                            </thead>
                            <tbody>
                            <!-- 데이터 행들 -->
                            <c:forEach var="user" items="${user}">
                                <tr onclick="window.location.href='customer-detail?id=${user.userId}'" style="cursor: pointer;">
                                    <td>${user.userId}</td>
                                    <td>${user.userUsername}</td>
                                    <td>${user.userTel}</td>
                                    <td>${user.userEmail}</td>
                                    <td>${user.userName}</td>
                                    <td>${user.userZipcode}</td>
                                    <td>${user.userDetailAdd1}</td>
                                    <td>${user.userDetailAddr1}</td>
                                    <td>${user.userDetailAddr2}</td>
                                    <td>${user.userStatus}</td>
                                </tr>
                            </c:forEach>
                            </tbody>

                            <%--                            <tfoot>--%>
                            <%--                            <tr>--%>
                            <%--                                <th>User ID</th>--%>
                            <%--                                <th>Username</th>--%>
                            <%--                                <th>Password</th>--%>
                            <%--                                <th>Tel</th>--%>
                            <%--                                <th>Email</th>--%>
                            <%--                                <th>Name</th>--%>
                            <%--                                <th>Birthday</th>--%>
                            <%--                                <th>Zipcode</th>--%>
                            <%--                                <th>Address1</th>--%>
                            <%--                                <th>Address2</th>--%>
                            <%--                                <th>Address3</th>--%>
                            <%--                                <th>Registration Date</th>--%>
                            <%--                                <th>Status</th>--%>
                            <%--                                <th>Profile</th>--%>
                            <%--                            </tr>--%>
                            <%--                            </tfoot>--%>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Required vendors -->
<script src="./vendor/global/global.min.js"></script>
<script src="./js/quixnav-init.js"></script>
<script src="./js/custom.min.js"></script>

<!-- Datatable -->
<script src="./vendor/datatables/js/jquery.dataTables.min.js"></script>
<script src="./js/plugins-init/datatables.init.js"></script>
