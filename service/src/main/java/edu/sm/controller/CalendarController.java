package edu.sm.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Slf4j
@RequiredArgsConstructor
public class CalendarController {
    String dir = "calendar/";

    @Value("${app.key.google-calendar-api-key}")
    private String googleCalendarApiKey;

    @Value("${app.key.google-calendar-id}")
    private String googleCalendarId;

    @RequestMapping("/fullcalendar-u")
    public String usercalendar(Model model, HttpSession session) throws Exception {
        model.addAttribute("googleCalendarApiKey", googleCalendarApiKey);
        model.addAttribute("googleCalendarId", googleCalendarId);
        model.addAttribute("center", dir + "calendar");
        return "index";
    }

    @RequestMapping("/fullcalendar-cw")
    public String cwcalendar(Model model, HttpSession session) throws Exception {
        model.addAttribute("googleCalendarApiKey", googleCalendarApiKey);
        model.addAttribute("googleCalendarId", googleCalendarId);
        model.addAttribute("center", dir + "calendar");
        return "index";
    }
}
