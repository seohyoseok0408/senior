package edu.sm.controller;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Slf4j
public class MainController {
    @Value("${app.url.server-url}")
    String serverurl;

    @RequestMapping("/")
    public String main(Model model) {
        log.info("Start Main");
        return "index"; // 메인 페이지로 이동
    }

    @RequestMapping("/login/user")
    public String loginUser(Model model) {
        model.addAttribute("center", "auth/login/user");
        return "index";
    }


    @RequestMapping("/login/careworker")
    public String loginCareworker(Model model) {
        model.addAttribute("center", "auth/login/careworker");
        return "index";
    }

    @RequestMapping("/signup/user")
    public String signupUser(Model model) {
        model.addAttribute("center", "auth/signup/user");
        return "index";
    }

    @RequestMapping("/signup/careworker")
    public String signupCareworker(Model model) {
        model.addAttribute("center", "auth/signup/careworker");
        return "index";
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // 세션 초기화 (로그아웃 처리)
        return "redirect:/"; // 메인 페이지로 리다이렉트
    }

    @RequestMapping("/video")
    public String video(Model model) {
        model.addAttribute("center", "user/video");
        return "index";
    }

    @RequestMapping("/about")
    public String about(Model model) {
        return "about"; // About 페이지로 이동
    }

    @RequestMapping("/contact")
    public String contact(Model model) {
        return "contact"; // Contact 페이지로 이동
    }

    @RequestMapping("/team")
    public String team(Model model) {
        return "team"; // Team 페이지로 이동
    }

    @RequestMapping("/why")
    public String why(Model model) {
        return "why"; // Why Choose Us 페이지로 이동
    }

    @RequestMapping("/client")
    public String client(Model model) {
        return "client";
    }

    @RequestMapping("/chat")
    public String chat(Model model) {
        model.addAttribute("serverurl", serverurl);
        model.addAttribute("center", "chat");
        return "index";
    }

    @RequestMapping("/chatbot")
    public String chatbot(Model model) {
        model.addAttribute("center", "chatbot");
        return "index";
    }

    @RequestMapping("/websocket")
    public String websocket(Model model) {
        model.addAttribute("serverurl", serverurl);
        model.addAttribute("center", "websocket");
        return "index";
    }
}

