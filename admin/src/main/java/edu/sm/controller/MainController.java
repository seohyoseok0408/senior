package edu.sm.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
@Controller
@Slf4j
@RequiredArgsConstructor
public class MainController {

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

    @RequestMapping("/login")
    public String login(Model model) {
        return "login";
    }
}
