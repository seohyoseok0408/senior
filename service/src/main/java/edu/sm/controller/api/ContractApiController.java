package edu.sm.controller.api;


import edu.sm.dto.ResponseDto;
import edu.sm.model.Contract;
import edu.sm.model.Message;
import edu.sm.model.Schedule;
import edu.sm.service.ContractService;
import edu.sm.service.MessageService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;
import java.util.Map;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/contract")
public class ContractApiController {
    private final ContractService contractService;
    private final MessageService messageService;

    @PostMapping("")
    public ResponseDto<String> contract(@RequestBody Map<String, Object> request, HttpSession session) {

        try {
            log.info("Request received: {}", request);

            // 세션에서 사용자 ID 가져오기
            Object principal = session.getAttribute("principal");
            if (principal == null) {
                return new ResponseDto<>(HttpStatus.UNAUTHORIZED.value(), "로그인이 필요합니다.");
            }

            log.info("Principal in session: {}", principal);

            // 세션 값이 String 타입일 경우 Integer로 변환
            int userId;
            try {
                userId = Integer.parseInt(principal.toString());
            } catch (NumberFormatException e) {
                log.error("Session principal attribute cannot be converted to Integer: {}", principal, e);
                return new ResponseDto<>(HttpStatus.BAD_REQUEST.value(), "세션 사용자 ID가 올바르지 않습니다.");
            }

            // 계약 데이터 설정
            int cwId = Integer.parseInt(request.get("cwId").toString());
            int seniorId = Integer.parseInt(request.get("seniorId").toString());

            Contract contract = Contract.builder().userId(userId).cwId(cwId).seniorId(seniorId).build();

            // 스케줄 데이터 설정
            String startDatetimeStr = (String) request.get("contractStartDatetime");
            String endDatetimeStr = (String) request.get("contractEndDatetime");
            LocalDateTime startDatetime;
            LocalDateTime endDatetime;
            try {
                startDatetime = LocalDateTime.parse(startDatetimeStr);
                endDatetime = LocalDateTime.parse(endDatetimeStr);
            } catch (DateTimeParseException e) {
                log.error("Invalid date format: {}", e.getMessage());
                return new ResponseDto<>(HttpStatus.BAD_REQUEST.value(), "잘못된 날짜 형식입니다.");
            }

            Schedule schedule = Schedule.builder().scheduleStartDatetime(startDatetime).scheduleEndDatetime(endDatetime).cwId(cwId).userId(userId).build();

            // 계약 및 스케줄 생성
            contractService.createContractAndSchedule(contract, schedule);

            return new ResponseDto<>(HttpStatus.OK.value(), "계약 및 스케줄 생성 성공");
        } catch (Exception e) {
            log.error("Error creating contract and schedule", e);
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "계약 생성 중 오류 발생");
        }
    }


    @PutMapping("")
    public ResponseDto<String> approveContract(@RequestBody Contract contract) {
        try {
            contractService.modify(contract);
            log.info("고객아이디: " + contract.getUserId());
            log.info("보호사아이디: " + contract.getCwId());
            messageService.aproveContract(contract.getUserId(), contract.getCwId());
            return new ResponseDto<>(HttpStatus.OK.value(), "계약 승인 성공");
        } catch (Exception e) {
            log.error("Error approving contract", e);
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "계약 승인 중 오류 발생");
        }
    }


}


