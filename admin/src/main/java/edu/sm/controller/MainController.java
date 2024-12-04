package edu.sm.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@Slf4j
@RequiredArgsConstructor
public class MainController {
    @Value("${app.url.server-url}")
    String serverUrl;

    @RequestMapping("/")
    public String main(Model model, HttpSession session) {
        // 로그인 하지 않은 상태로 접근시 로그인 반환
        if (session.getAttribute("principal") == null) {
            // If "principal" is null, redirect to the login page
            return "redirect:/login";
        }
        model.addAttribute("center", "center");
        model.addAttribute("sidebar", "sidebar");
        return "index";
    }

    @RequestMapping("/websocket")
    public String websocket(@RequestParam Integer userId, Model model) {
        model.addAttribute("userId", userId);
        model.addAttribute("serverurl", serverUrl);
        model.addAttribute("center", "websocket");
        return "index";
    }

    @RequestMapping("/chat")
    public String chat(Model model) {
        model.addAttribute("serverurl", serverUrl);
        model.addAttribute("center", "chat");
        return "index";
    }

    @RequestMapping("/login")
    public String login(Model model) {
        return "login";
    }

    @RequestMapping("/register")
    public String register(Model model) {
        return "register";
    }
}
