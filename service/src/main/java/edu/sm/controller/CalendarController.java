package edu.sm.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClientService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Slf4j
@RequiredArgsConstructor
public class CalendarController {
    private final OAuth2AuthorizedClientService authorizedClientService;
    String dir = "calendar/";

    @RequestMapping("/fullcalendar-u")
    public String usercalendar(Model model, HttpSession session) throws Exception {
        model.addAttribute("center", dir + "calendar");
        return "index";
    }

    @RequestMapping("/fullcalendar-cw")
    public String cwcalendar(Model model, HttpSession session) throws Exception {
        model.addAttribute("center", dir + "calendar");
        return "index";
    }

}
