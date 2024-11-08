package edu.sm.controller.api;

import edu.sm.dto.ResponseDto;
import edu.sm.model.Admin;
import edu.sm.service.AdminService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.http.auth.InvalidCredentialsException;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.parameters.P;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Slf4j
@RequiredArgsConstructor
public class AdminApiController {

    private final AdminService adminService;

    @PostMapping("/api/admin/signup")
    public ResponseDto<Integer> save(@RequestBody Admin admin) {
        try {
            adminService.add(admin);
            return new ResponseDto<>(HttpStatus.OK.value(), 1);
        } catch (IllegalArgumentException e) {
            log.error("잘못된 입력 값입니다.", e);
            return new ResponseDto<>(HttpStatus.BAD_REQUEST.value(), 0);
        } catch (Exception e) {
            log.error("예기치 않은 오류 발생", e);
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), 0);
        }
    }

    @PostMapping("/api/admin/login")
    public ResponseDto<Integer> login(@RequestBody Admin admin, HttpSession session) {
        try {
            Admin principal = adminService.login(admin);
            session.setAttribute("principal", principal);
            return new ResponseDto<>(HttpStatus.OK.value(), 1);
        } catch (UsernameNotFoundException e) {
            log.error("존재하지 않는 사용자 아이디입니다.", e);
            return new ResponseDto<>(HttpStatus.NOT_FOUND.value(), 0); // 사용자 아이디가 없는 경우 404 반환
        } catch (InvalidCredentialsException e) {
            log.error("비밀번호가 일치하지 않습니다.", e);
            return new ResponseDto<>(HttpStatus.UNAUTHORIZED.value(), 0); // 비밀번호 오류인 경우 401 반환
        } catch (IllegalArgumentException e) {
            log.error("잘못된 입력 값입니다.", e);
            return new ResponseDto<>(HttpStatus.BAD_REQUEST.value(), 0);
        } catch (Exception e) {
            log.error("예기치 않은 오류 발생", e);
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), 0);
        }
    }

}
