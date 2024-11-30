package edu.sm.controller;

import edu.sm.model.Careworker;
import edu.sm.model.Senior;
import edu.sm.service.CareworkerService;
import edu.sm.service.SeniorService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/careworker")
public class CareworkerController {
    private final SeniorService seniorService;
    private final CareworkerService careworkerService;

    @RequestMapping("/mypage")
    public String Mypage(HttpSession session, Model model) {
        Integer cwId = (Integer) session.getAttribute("principal"); // 세션에서 principal 가져오기
        if (cwId == null) {
            log.warn("No principal found in session. Redirecting to login.");
            return "redirect:/login/careworker";
        }
        model.addAttribute("cwId", cwId); // JSP에서 사용할 cwId 추가
        model.addAttribute("center", "careworker/mypage");
        return "index";
    }

    @RequestMapping("/worklog/saveform")
    public String saveForm(@RequestParam Integer seniorId, Model model) {
        try {
            Senior senior = seniorService.get(seniorId);
            log.info("seniorInfo: {}", senior);
            model.addAttribute("senior", senior);
            model.addAttribute("center", "careworker/saveform");
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
        return "index";
    }
}
