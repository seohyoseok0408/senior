package edu.sm.controller.api;

import edu.sm.dto.ResponseDto;
import edu.sm.model.Careworker;
import edu.sm.service.CareworkerService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/careworkers")
public class CareworkerApiController {

    private final CareworkerService careworkerService;

    // 사용자 정보 조회 API 엔드포인트
    @GetMapping("/{cwId}")
    public ResponseDto<Careworker> getUser(@PathVariable int cwId) {
        try {
            Careworker careworker = careworkerService.get(cwId);
            return new ResponseDto<>(HttpStatus.OK.value(), careworker);
        } catch (Exception e) {
            log.error("사용자 조회 중 오류 발생", e);
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), null);
        }
    }

    @PostMapping("/signup")
    public ResponseDto<String> save(@ModelAttribute Careworker careworker) {
        try {
            careworker.setCwProfile(careworker.getCwProfileFile().getOriginalFilename());
            careworkerService.add(careworker);
            return new ResponseDto<>(HttpStatus.OK.value(), "1");
        } catch (IllegalArgumentException e) {
            return new ResponseDto<>(HttpStatus.BAD_REQUEST.value(), e.getMessage());
        } catch (Exception e) {
            log.info(e.getMessage());
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "예기치 않은 오류 발생");
        }
    }

    @PostMapping("/login")
    public ResponseDto<String> login(@RequestBody Careworker careworker, HttpSession session) {
        try {
            Careworker principal = careworkerService.login(careworker);
            session.setAttribute("name", principal.getCwName());
            session.setAttribute("principal", principal.getCwId()); // 세션에 Careworker ID 저장
            session.setAttribute("role", "CAREWORKER"); // 역할 정보 저장
            return new ResponseDto<>(HttpStatus.OK.value(), "1");
        } catch (IllegalArgumentException e) {
            return new ResponseDto<>(HttpStatus.UNAUTHORIZED.value(), e.getMessage());
        } catch (Exception e) {
            log.error("로그인 중 예기치 않은 오류 발생", e);
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "예기치 않은 오류 발생");
        }
    }



    @GetMapping("/nearby")
    public List<Careworker> findNearbyCareworkers(
            @RequestParam Double latitude,
            @RequestParam Double longitude,
            @RequestParam Double radius
    ) {
        List<Careworker> careworkers = null;
        try {
            log.info("latitude: " + latitude + ", longitude: " + longitude + ", radius: " + radius);
            careworkers = careworkerService.getCareworkersWithinRadius(latitude, longitude, radius);
            log.info("cacarere: " + careworkers.toString());
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        log.info(careworkers.toString());
        return careworkers;
    }

}
