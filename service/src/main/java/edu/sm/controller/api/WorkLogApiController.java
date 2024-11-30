package edu.sm.controller.api;

import edu.sm.dto.ResponseDto;
import edu.sm.model.WorkLog;
import edu.sm.service.WorkLogService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/board")
public class WorkLogApiController {
    private final WorkLogService workLogService;

    @PostMapping("")
    public ResponseDto<Integer> save(@RequestBody WorkLog workLog) {
        log.info(workLog.toString());
        try {
            workLogService.add(workLog);
            return new ResponseDto<Integer>(HttpStatus.OK.value(), 1);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
