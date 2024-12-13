package edu.sm.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import edu.sm.model.Senior;
import edu.sm.model.User;
import edu.sm.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@Slf4j
@RequiredArgsConstructor
public class UserController {

    final UserService userService;
    String dir = "user/";

    @RequestMapping("/customer-list")
    public String list(Model model, HttpSession session) throws Exception {
        // 전체 유저 리스트 가져오기
        List<User> user = userService.get();
        // 신규 가입자 추이 데이터 가져오기
        List<Map<String, Object>> signupTrends = userService.getMonthlySignupStats();

        // 현재 시점부터 12개월 데이터 생성
        LocalDate currentMonth = LocalDate.now().withDayOfMonth(1); // 현재 달의 시작
        List<Map<String, Object>> last12Months = new ArrayList<>();

        for (int i = 0; i < 12; i++) {
            String month = currentMonth.minusMonths(11 - i).format(DateTimeFormatter.ofPattern("yyyy-MM"));
            Map<String, Object> monthData = signupTrends.stream().filter(data -> month.equals(data.get("signup_month"))).findFirst().orElse(Map.of("signup_month", month, "signup_count", 0)); // 없는 달은 0으로 채움
            last12Months.add(monthData);
        }

        // 현재 active/inactive 비율 데이터 가져오기
        List<Map<String, Object>> userStatusRatio = userService.getUserStatusCount();

        // ObjectMapper를 사용하여 JSON 형식으로 변환
        ObjectMapper objectMapper = new ObjectMapper();
        String signupTrendsJson = objectMapper.writeValueAsString(last12Months);
        String userStatusRatioJson = objectMapper.writeValueAsString(userStatusRatio);

        // JSON 로그 출력
        log.info("Signup Trends (JSON): {}", signupTrendsJson);
        log.info("User Status Ratio (JSON): {}", userStatusRatioJson);

        // Model에 데이터 추가
        model.addAttribute("user", user);
        model.addAttribute("signupTrends", signupTrendsJson);
        model.addAttribute("userStatusRatio", userStatusRatioJson);

        // Center 페이지 설정
        model.addAttribute("center", dir + "userList");

        return "index";
    }

    // 새로운 채팅 관리 추가
    @RequestMapping("/customer-chatlist")
    public String chatList(Model model) throws Exception {
        // 모든 유저 리스트 가져오기
        List<User> userList = userService.get(); // userService에서 모든 유저를 가져오는 메서드 호출

        // 유저 리스트를 모델에 추가
        model.addAttribute("userList", userList);

        // JSP 경로 설정
        model.addAttribute("center", "chat/chatList"); // JSP 경로
        return "index";
    }

    @RequestMapping("/customer-detail")
    public String detail(Model model, @RequestParam("id") Integer userId) throws Exception {
        User user = userService.get(userId);
        List<Senior> senior = userService.getSeniorsByUserId(userId);

        log.info(user.toString());
        model.addAttribute("user", user);
        model.addAttribute("senior", senior);
        model.addAttribute("center", dir + "userDetail");
        // 이 위로는 건들지 않는다 ㅇㅋ?

        // Total Contract Amount 계산
        Long totalContractAmount = userService.getTotalContractAmountByUserId(userId);
        model.addAttribute("totalContractAmount", totalContractAmount != null ? totalContractAmount.intValue() : 0);

        // 연결 시니어 명수 계산
        Long seniorCount = userService.getSeniorCountByUserId(userId);
        model.addAttribute("seniorCount", seniorCount != null ? seniorCount.intValue() : 0);

        // 계약 갱신 횟수 조회
        Long renewalCount = userService.getContractRenewalCountByUserId(userId);
        model.addAttribute("contractRenewalCount", renewalCount != null ? renewalCount.intValue() : 0);

        return "index";
    }


}
