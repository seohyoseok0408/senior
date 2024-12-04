package edu.sm.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import edu.sm.model.Schedule;
import edu.sm.service.CalendarService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
public class CalendarController {

    private final CalendarService calendarService;
    private final String dir = "calendar/";

    @RequestMapping("/fullcalendar-u")
    public String userCalendar(Model model, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("principal");
        if (userId == null) {
            return "redirect:/login/user";
        }
        log.info("User ID: {}", userId);

        List<Schedule> schedules = calendarService.getSchedulesByUserId(userId);
        try {
            // ObjectMapper 생성 및 JavaTimeModule 등록
            ObjectMapper objectMapper = new ObjectMapper();
            objectMapper.registerModule(new JavaTimeModule());
            objectMapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS); // 배열 대신 ISO 8601 사용

            // JSON 변환
            String schedulesJson = objectMapper.writeValueAsString(schedules);
            model.addAttribute("schedulesJson", schedulesJson);
            log.info(schedulesJson);
        } catch (JsonProcessingException e) {
            log.error("Error converting schedules to JSON", e);
            model.addAttribute("schedulesJson", "[]");
        }


        model.addAttribute("center", dir + "calendar");
        return "index";
    }

    @RequestMapping("/fullcalendar-cw")
    public String cwCalendar(Model model, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("principal");
        if (userId == null) {
            return "redirect:/login/user";
        }
        log.info("User ID: {}", userId);

        List<Schedule> schedules = calendarService.getSchedulesByUserId(userId);
        try {
            // ObjectMapper 생성 및 JavaTimeModule 등록
            ObjectMapper objectMapper = new ObjectMapper();
            objectMapper.registerModule(new JavaTimeModule());
            objectMapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS); // 배열 대신 ISO 8601 사용

            // JSON 변환
            String schedulesJson = objectMapper.writeValueAsString(schedules);
            model.addAttribute("schedulesJson", schedulesJson);
            log.info(schedulesJson);
        } catch (JsonProcessingException e) {
            log.error("Error converting schedules to JSON", e);
            model.addAttribute("schedulesJson", "[]");
        }


        model.addAttribute("center", dir + "calendar");
        return "index";
    }
}
