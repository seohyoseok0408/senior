package edu.sm.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Slf4j
public class MainController {

    @RequestMapping("/")
    public String main(Model model) {
        log.info("Start Main");
        return "index"; // 메인 페이지로 이동
    }
    @RequestMapping("/index")
    public String index(Model model) {
        log.info("Start Main");
        return "index"; // 메인 페이지로 이동
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
}
