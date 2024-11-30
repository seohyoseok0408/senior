package edu.sm.controller;

import edu.sm.model.HealthInfo;
import edu.sm.model.Senior;
import edu.sm.service.HealthinfoService;
import edu.sm.service.SeniorService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/seniors")
public class SeniorController {
    private final SeniorService seniorService;
    private final HealthinfoService healthinfoService;

    @RequestMapping("/{id}")
    public String detail(@PathVariable Integer id, HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("principal");
        if (userId == null) {
            return "redirect:/";
        }
        try {
            Senior senior  = seniorService.get(id);
            if (senior == null) {
                return "redirect:/senior";
            }
            List<HealthInfo> healthinfo = healthinfoService.getHealthInfoBySeniorId(id);

            model.addAttribute("center", "senior/detail");
            model.addAttribute("senior", senior);
            model.addAttribute("healthinfo", healthinfo);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return "index";
    }

    @RequestMapping("/map/{id}")
    public String list(@PathVariable Integer id, Model model) {
        Senior senior = null;
        try {
            senior = seniorService.get(id);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        model.addAttribute("senior", senior);
        model.addAttribute("center", "senior/map");
        return "index";
    }
}
