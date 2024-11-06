package edu.sm.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Slf4j
@RequiredArgsConstructor
public class MainController {

    @RequestMapping("/main")
    public String main(Model model) {
        model.addAttribute("header", "header");
        model.addAttribute("center", "center");
        model.addAttribute("sidebar", "sidebar");
        return "index";
    }

    @RequestMapping("/")
    public String login(Model model) {
        return "login";
    }
}
