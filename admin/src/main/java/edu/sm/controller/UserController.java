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
public class UserController {

    String dir = "user/";

    @RequestMapping("/customer-list")
    public String main(Model model, HttpSession session) {
        model.addAttribute("header", "header");
        model.addAttribute("center", dir+"userList");
        model.addAttribute("sidebar", "sidebar");
        return "index";
    }
}
