package edu.sm.controller.api;

import edu.sm.dto.ResponseDto;
import edu.sm.model.Senior;
import edu.sm.service.SeniorService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

@RestController
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/api/senior")
public class SeniorController {

    private final SeniorService seniorService;

    // 시니어 등록
    @PostMapping("/register")
    public ResponseDto<Integer> register(@RequestBody Senior senior) {
        log.info("Senior registration initiated.");
        try {
            seniorService.add(senior);
            log.info("Senior registered successfully: {}", senior);
            return new ResponseDto<>(HttpStatus.OK.value(), 1); // 성공 시 1 반환
        } catch (Exception e) {
            log.error("Error registering senior", e);
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), 0); // 실패 시 0 반환
        }
    }

    // 시니어 수정
    @PutMapping("/edit")
    public ResponseDto<Integer> edit(@RequestBody Senior senior) {
        try {
            seniorService.modify(senior);
            log.info("Senior updated successfully: {}", senior);
            return new ResponseDto<>(HttpStatus.OK.value(), 1); // 성공 시 1 반환
        } catch (Exception e) {
            log.error("Error editing senior", e);
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), 0); // 실패 시 0 반환
        }
    }

    // 시니어 상태를 inactive로 설정하여 "삭제" 처리
    @DeleteMapping("/delete/{id}")
    public ResponseDto<Integer> delete(@PathVariable Integer id) {
        try {
            seniorService.del(id);
            log.info("Senior status updated to inactive, id: {}", id);
            return new ResponseDto<>(HttpStatus.OK.value(), 1); // 성공 시 1 반환
        } catch (Exception e) {
            log.error("Error updating senior status to inactive", e);
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), 0); // 실패 시 0 반환
        }
    }
}
