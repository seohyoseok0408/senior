package edu.sm.controller.api;

import edu.sm.dto.ResponseDto;
import edu.sm.model.User;
import edu.sm.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

@RestController
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/api/users")
public class UserApiController {

    private final UserService userService;

    @PostMapping("/signup")
    public ResponseDto<String> registerUser(@ModelAttribute User user) {
        try {
            user.setUserProfile(user.getUserProfileFile().getOriginalFilename());
            userService.add(user);
            return new ResponseDto<>(HttpStatus.OK.value(), "1");
        } catch (IllegalArgumentException e) {
            return new ResponseDto<>(HttpStatus.BAD_REQUEST.value(), e.getMessage());
        } catch (Exception e) {
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), e.getMessage());
        }
    }

    // 사용자 정보 조회 API 엔드포인트
    @GetMapping("/{userId}")
    public ResponseDto<User> getUser(@PathVariable int userId) {
        try {
            User user = userService.get(userId);
            return new ResponseDto<>(HttpStatus.OK.value(), user);
        } catch (Exception e) {
            log.error("사용자 조회 중 오류 발생", e);
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), null);
        }
    }

    @PostMapping("/login")
    public ResponseDto<String> login(@RequestBody User user, HttpSession session) {
        try {
            User principal = userService.login(user);
            session.setAttribute("name", principal.getUserName());
            session.setAttribute("principal", principal.getUserId());
            session.setAttribute("role", "USER");
            return new ResponseDto<>(HttpStatus.OK.value(), "1");
        } catch (IllegalArgumentException e) {
            return new ResponseDto<>(HttpStatus.UNAUTHORIZED.value(), e.getMessage());
        } catch (Exception e) {
            log.error("로그인 중 예기치 않은 오류 발생", e);
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "예기치 않은 오류 발생");
        }
    }


    // 아이디 찾기 API
    @GetMapping("/findid")
    public ResponseDto<String> findId(@RequestParam String userEmail) {
        try {
            String username = userService.findIdByEmail(userEmail);
            return new ResponseDto<>(HttpStatus.OK.value(), username);
        } catch (Exception e) {
            log.error("아이디 찾기 실패", e);
            return new ResponseDto<>(HttpStatus.NOT_FOUND.value(), null);
        }
    }

    // 회원 정보 수정 (비밀번호 제외)
    @PutMapping("/update/{id}")
    public ResponseDto<Integer> updateUserInfo(@PathVariable Integer id, @RequestBody User user) {
        try {
            userService.modifyById(id, user);  // 기본 정보 수정
            return new ResponseDto<>(HttpStatus.OK.value(), 1);
        } catch (Exception e) {
            log.error("회원 정보 수정 중 오류 발생", e);
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), 0);
        }
    }

    // 비밀번호 변경
    @PutMapping("/update/password/{id}")
    public ResponseDto<Integer> updatePassword(@PathVariable Integer id, @RequestBody String newPassword) {
        try {
            log.info(newPassword);
            userService.updatePassword(id, newPassword); // 비밀번호 수정 서비스 호출
            return new ResponseDto<>(HttpStatus.OK.value(), 1);
        } catch (Exception e) {
            log.error("비밀번호 수정 중 오류 발생", e);
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), 0);
        }
    }

    // 유저 상태를 inactive로 설정하여 "소프트 삭제" 처리
    @DeleteMapping("/delete/{id}")
    public ResponseDto<Integer> delete(@PathVariable Integer id) {
        try {
            userService.del(id); // 상태를 inactive로 변경
            return new ResponseDto<>(HttpStatus.OK.value(), 1); // 성공 시 1 반환
        } catch (Exception e) {
            log.error("유저 소프트 삭제 중 오류 발생", e);
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), 0);
        }
    }
}
