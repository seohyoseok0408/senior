package edu.sm.controller.api;

import edu.sm.dto.ResponseDto;
import edu.sm.model.Admin;
import edu.sm.service.AdminService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.parameters.P;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Slf4j
@RequiredArgsConstructor
public class AdminApiController {

    private final AdminService adminService;

    @PostMapping("/api/admin/login")
    public ResponseDto<Integer> login(@RequestBody Admin admin, HttpSession session) {
        log.info("Admin login 호출됨");

        Admin principal = null;
        String username = admin.getAdminUsername();
        log.info("username: " + username);
        try {
            principal = adminService.getByUsername(username);
            if (principal == null) { // principal이 null이면 아이디가 없는 것
                throw new Exception();
            }
            if (!principal.getAdminPassword().equals(admin.getAdminPassword())) { // 비밀번호가 틀린 경우
                throw new Exception();
            }
            session.setAttribute("principal", principal);
        } catch (Exception e) {
            log.error("Admin login 오류", e);
            return new ResponseDto<Integer>(HttpStatus.OK.value(), 0);
        }
        return new ResponseDto<Integer>(HttpStatus.OK.value(), 1);
    }
}
