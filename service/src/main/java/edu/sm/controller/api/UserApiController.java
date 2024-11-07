package edu.sm.controller.api;

import edu.sm.model.User;
import edu.sm.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/api/users")
public class UserApiController {

    private final UserService userService;

    // 회원가입 API 엔드포인트
    @PostMapping("/signup")
    public ResponseEntity<String> registerUser(@RequestBody User user) {
        log.info("User signup 호출됨");

        try {
            userService.registerUser(user);
            log.info("User registered successfully: {}", user.getUsername());
            return ResponseEntity.status(HttpStatus.CREATED).body("User registered successfully");
        } catch (IllegalArgumentException e) {
            log.error("Validation error during registration", e);
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Validation error: " + e.getMessage());
        } catch (Exception e) {
            log.error("An error occurred during registration", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred during registration");
        }
    }

    // 사용자 정보 조회 API 엔드포인트
    @GetMapping("/{userId}")
    public ResponseEntity<User> getUser(@PathVariable int userId) {
        log.info("Fetching user info for userId: {}", userId);

        try {
            User user = userService.getUserById(userId);
            if (user == null) {
                log.warn("User not found for userId: {}", userId);
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
            }
            return ResponseEntity.ok(user);
        } catch (Exception e) {
            log.error("Error fetching user information", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }
}
