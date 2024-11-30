package edu.sm.controller.api;


import edu.sm.dto.ResponseDto;
import edu.sm.model.Contract;
import edu.sm.service.ContractService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/contract")
public class ContractApiController {
    private final ContractService contractService;

    @PostMapping("")
    public ResponseDto<String> contract(@RequestBody Contract contract, HttpSession session) {
        try {
            int userId = (int) session.getAttribute("principal");
            contract.setUserId(userId);

            contractService.add(contract);
            return new ResponseDto<>(HttpStatus.OK.value(), "계약 신청 성공");
        } catch (Exception e) {
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "예기치 않은 오류 발생");
        }
    }
}


