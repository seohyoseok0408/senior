package edu.sm.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import edu.sm.model.KakaoProfile;
import edu.sm.model.OAuthToken;
import edu.sm.model.User;
import edu.sm.service.UserService;
import edu.sm.util.PasswordUtil;
import edu.sm.util.PhoneNumberUtil;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;


@Slf4j
@Controller
public class KaKaoController {

    private final UserService userService;

    public KaKaoController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("auth/kakao/callback")
    public String kakaoCallback(String code, Model model,HttpSession session) {
        log.info("카카오 인증 완료", code);

        RestTemplate rt = new RestTemplate();

        // HTTP Header 오브젝트 생성
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

        // HTTP Body 오브젝트 생성
        MultiValueMap params = new LinkedMultiValueMap<>();
        params.add("grant_type", "authorization_code");
        params.add("client_id", "64b9ea9d9f0617efc1cffc0e66813e95");
        params.add("redirect_uri", "http://127.0.0.1/auth/kakao/callback");
        params.add("code", code);

        // HTTP Header와 HTTP Body를 하나의 오브젝트에 담기
        HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest =
                new HttpEntity<>(params, headers);

        // HTTP 요청하기 - POST 방식으로 - 그리고 response 변수의 응답 받음
        ResponseEntity<String> response = rt.exchange(
                "https://kauth.kakao.com/oauth/token", HttpMethod.POST,
                kakaoTokenRequest,
                String.class);

        ObjectMapper objectMapper = new ObjectMapper();
        OAuthToken oAuthToken = null;
        try {
            oAuthToken = objectMapper.readValue(response.getBody(), OAuthToken.class);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }

        System.out.println("카카오 엑세스 토큰 : " + oAuthToken.getAccess_token());

        RestTemplate rt2 = new RestTemplate();

        // HTTP Header 오브젝트 생성
        HttpHeaders headers2 = new HttpHeaders();
        headers.add("Authorization", "Bearer " + oAuthToken.getAccess_token());
        headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

        // HTTP Header와 HTTP Body를 하나의 오브젝트에 담기
        HttpEntity<MultiValueMap<String, String>> kakaoProfileRequest2 =
                new HttpEntity<>(headers);

        // HTTP 요청하기 - POST 방식으로 - 그리고 response 변수의 응답 받음
        ResponseEntity<String> response2 = rt2.exchange(
                "https://kapi.kakao.com/v2/user/me", HttpMethod.POST,
                kakaoProfileRequest2,
                String.class);
        System.out.println(response2.getBody());

        ObjectMapper objectMapper2 = new ObjectMapper();
        KakaoProfile kakaoProfile = null;
        try {
            kakaoProfile = objectMapper2.readValue(response2.getBody(), KakaoProfile.class);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }

        // User 오브젝트 : username, password, email
        System.out.println("카카오 아이디(번호) : "+kakaoProfile.getId());
        System.out.println("카카오 이메일 : "+kakaoProfile.getKakao_account().getEmail());

        System.out.println("시니어서버 유저네임 : "+kakaoProfile.getKakao_account().getEmail()+"_"+kakaoProfile.getId());
        System.out.println("시니어서버 이메일 : "+kakaoProfile.getKakao_account().getEmail());

        String tempPassword = PasswordUtil.generateRandomPassword(12); // 길이 12의 임시 비밀번호 생성

        String birthYear = kakaoProfile.getKakao_account().getBirthyear();
        String birthDay = kakaoProfile.getKakao_account().getBirthday();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
        LocalDate userBirthday = LocalDate.parse(birthYear + birthDay, formatter);

        String rowPhoneNumber = kakaoProfile.getKakao_account().getPhone_number();
        String formattedPhoneNumber = PhoneNumberUtil.formatPhoneNumber(rowPhoneNumber);


        User kakaoUser = User.builder()
                .userUsername(kakaoProfile.getKakao_account().getEmail()+"_"+kakaoProfile.getId())
                .userPassword(tempPassword)
                .userName(kakaoProfile.getKakao_account().getName())
                .userBirthday(userBirthday)
                .userEmail(kakaoProfile.getKakao_account().getEmail())
                .userTel(formattedPhoneNumber)
                .userProfile(null)
                .build();

        User originUser = null;
        try {
            originUser = userService.getUsername(kakaoUser.getUserUsername());
            if (originUser == null) {
                System.out.println("신규 회원 가입 진행");

                session.setAttribute("kakaoUser", kakaoUser); // 추가 정보 입력 시 활용

                model.addAttribute("center", "auth/signup/signup_kakao");
                return "index"; // 추가 정보 입력 페이지로 리디렉션
            } else {
                System.out.println("자동 로그인 진행");

                session.setAttribute("principal", originUser.getUserId());
                session.setAttribute("name", originUser.getUserName());
                session.setAttribute("role", "USER");
                return "redirect:/";
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }
}
