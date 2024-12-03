<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container mt-5">
    <!-- 지도 표시 -->
    <div id="map"
         data-cw-lat="${contractDetails.careworker.cwLatitude}"
         data-cw-lng="${contractDetails.careworker.cwLongitude}"
         data-sr-lat="${contractDetails.senior.seniorLatitude}"
         data-sr-lng="${contractDetails.senior.seniorLongitude}"
         style="width: 100%; height: 500px; border-radius: 8px; overflow: hidden;"
         class="mb-5 shadow-sm"></div>

    <!-- 계약 상세 -->
    <div class="card shadow-lg border-0">
        <div class="card-header text-center">
            <h4 class="mb-0">${contractDetails.user.userName} 고객님</h4>
        </div>
        <div class="card-body">
            <!-- 시니어 프로필 및 정보 -->
            <div class="row align-items-center mb-4">
                <div class="col-md-3 text-center">
                    <img src="/imgs/senior/${contractDetails.senior.seniorProfile}"
                         alt="시니어 프로필"
                         class="rounded-circle shadow"
                         style="width: 120px; height: 120px; object-fit: cover;">
                </div>
                <div class="col-md-9">
                    <h5 class="mb-2"><strong>시니어 이름:</strong> ${contractDetails.senior.seniorName}</h5>
                    <p class="mb-1"><strong>생년월일:</strong> ${contractDetails.senior.seniorBirth}</p>
                    <p class="mb-1"><strong>주소:</strong> ${contractDetails.senior.seniorStreetAddr}</p>
                </div>
            </div>

            <!-- 계약 정보 -->
            <div class="mb-4">
                <h5 class="mb-3">계약 정보</h5>
                <div class="row">
                    <div class="col-md-4">
                        <input type="hidden" id="contractId" value="${contractDetails.contract.contractId}">
                        <label for="contractStartDate" class="form-label">시작일</label>
                        <input type="date" class="form-control" id="contractStartDate" value="${contractDetails.contractStartDate}">
                    </div>
                    <div class="col-md-4">
                        <label for="contractEndDate" class="form-label">종료일</label>
                        <input type="date" class="form-control" id="contractEndDate" value="${contractDetails.contractEndDate}">
                    </div>
                    <div class="col-md-4">
                        <label for="contractPrice" class="form-label">계약 금액</label>
                        <input type="number" class="form-control" id="contractPrice" value="${contractDetails.contractPrice}">
                    </div>
                </div>
            </div>
        </div>

        <!-- 버튼 -->
        <div class="card-footer text-center">
            <c:if test="${contractDetails.contract.contractStatus == 'PENDING'}">
                <button type="button" class="btn btn-success btn-lg px-5" id="btn-approve">수락</button>
            </c:if>
            <a href="/careworker/contracts" class="btn btn-secondary btn-lg px-5">취소</a>
        </div>
    </div>
</div>

<script src="/js/contract_detail.js"></script>
