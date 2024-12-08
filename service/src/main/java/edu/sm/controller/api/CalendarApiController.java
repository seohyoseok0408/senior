package edu.sm.controller.api;

import edu.sm.dto.ResponseDto;
import edu.sm.model.Schedule; // 일정 데이터를 저장할 모델 클래스
import edu.sm.service.CalendarService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/calendar")
public class CalendarApiController {

    private final CalendarService calendarService;

    // 계약과 관련 없는 사용자 일정 저장
    @PostMapping("/saveUserSchedule")
    public ResponseDto<String> saveUserSchedule(@RequestBody Schedule schedule, HttpSession session) {
        try {
            // 데이터 검증
            if (schedule.getScheduleTitle() == null || schedule.getScheduleTitle().isEmpty()) {
                throw new Exception("스케줄 제목이 비어 있습니다.");
            }

            Integer userId = (Integer) session.getAttribute("principal");
            if (userId == null) {
                throw new Exception("유효한 사용자 정보가 없습니다.");
            }

            schedule.setUserId(userId);
            schedule.setScheduleStatus("ACTIVE");
            calendarService.addNonContractSchedule(schedule);

            return new ResponseDto<>(HttpStatus.OK.value(), "유저 일정 저장 성공");
        } catch (Exception e) {
            log.error("유저 일정 저장 실패:", e);
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "유저 일정 저장 실패");
        }
    }

    // 계약과 관련 없는 보호사 일정 저장
    @PostMapping("/saveCareworkerSchedule")
    public ResponseDto<String> saveCareworkerSchedule(@RequestBody Schedule schedule, HttpSession session) {
        try {
            Integer cwId = (Integer) session.getAttribute("cwId");
            if (cwId == null) {
                throw new Exception("유효한 보호사 정보가 없습니다.");
            }

            schedule.setCwId(cwId); // 보호사 ID 설정
            schedule.setScheduleStatus("ACTIVE"); // 기본 상태 설정
            calendarService.addNonContractSchedule(schedule);

            return new ResponseDto<>(HttpStatus.OK.value(), "보호사 일정 저장 성공");
        } catch (Exception e) {
            log.error("보호사 일정 저장 실패:", e);
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "보호사 일정 저장 실패");
        }
    }

    // 계약과 관련된 일정 저장
    @PostMapping("/saveContractSchedule")
    public ResponseDto<String> saveContractSchedule(@RequestBody Schedule schedule, HttpSession session) {
        try {
            // 계약 ID가 필수
            if (schedule.getContractId() == null) {
                throw new Exception("계약 ID가 필요합니다.");
            }

            schedule.setScheduleStatus("ACTIVE"); // 기본 상태 설정
            calendarService.addContractSchedule(schedule);

            return new ResponseDto<>(HttpStatus.OK.value(), "계약 일정 저장 성공");
        } catch (Exception e) {
            log.error("계약 일정 저장 실패:", e);
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "계약 일정 저장 실패");
        }
    }
}
