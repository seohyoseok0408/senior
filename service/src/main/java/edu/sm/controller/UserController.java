package edu.sm.controller;

import edu.sm.model.*;
import edu.sm.service.*;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/user")
public class UserController {
    private final UserService userService;
    private final SeniorService seniorService;
    private final HealthinfoService healthinfoService;
    private final CareworkerService careworkerService;
    private final WorkLogService workLogService;
    private final ContractService contractService;

    @GetMapping("/senior")
    public String seniors(HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("principal");
        if (userId == null) {
            return "redirect:/login/user"; // 로그인 페이지로 리다이렉트
        }

        try {
            Senior senior = seniorService.getSeniorsByUserId(userId);
            List<WorkLog> workLogs = workLogService.getBySeniorId(senior.getSeniorId());

            model.addAttribute("senior", senior);
            model.addAttribute("workLogs", workLogs);
            model.addAttribute("center", "senior/detail");
        } catch (Exception e) {
            return "redirect:/user/senior/insert";
        }

        return "index";
    }

    @RequestMapping("/senior/insert")
    public String seniorInsertForm(HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("principal");
        if (userId == null) {
            return "redirect:/login/user"; // 로그인 페이지로 리다이렉트
        }
        model.addAttribute("center", "user/senior/insert");
        return "index";
    }

    @RequestMapping("/mypage")
    public String Mypage(HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("principal");
        if (userId == null) {
            return "redirect:/login/user";
        }

        model.addAttribute("userId", userId); // userId 모델 추가
        model.addAttribute("center", "user/mypage"); // center 속성 추가
        return "index";
    }

    @RequestMapping("/careworkers")
    public String careworkerList(HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("principal");
        if (userId == null) {
            return "redirect:/login/user";
        }
        try {
            Senior senior = seniorService.getSeniorsByUserId(userId);

            model.addAttribute("senior", senior);
            model.addAttribute("center", "user/careworker/careworkerlist");

        } catch (Exception e) {
            return "redirect:/user/senior/insert";
        }
        return "index";
    }

    @RequestMapping("/careworkers/detail")
    public String cwDetail(@RequestParam Integer cwId, @RequestParam Integer seniorId, HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("principal");
        if (userId == null) {
            log.info("session is null");
            return "redirect:/";
        }

        try {
            Careworker careworker = careworkerService.get(cwId);
            if (careworker == null) {
                return "redirect:/";
            }

            log.info("careworker: {}", careworker);

            model.addAttribute("seniorId", seniorId);
            model.addAttribute("careworker", careworker);
            model.addAttribute("center", "user/careworker/detail");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return "index";
    }

    @RequestMapping("/rtc")
    public String video(Model model, HttpSession session) {
        Integer id = (Integer) session.getAttribute("principal");
        if (id == null) {
            return "redirect:/";
        }

        try {
            Contract contract = contractService.getContractByUserId(id);
            Integer contractId = contract.getContractId();
            User user = userService.get(id);

            model.addAttribute("user", user);
            model.addAttribute("contractId", contractId);
            model.addAttribute("center", "video");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return "index";
    }

    @RequestMapping("/map")
    public String list(HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("principal");
        if (userId == null) {
            return "redirect:/login/user"; // 로그인 페이지로 리다이렉트
        }

        try {
            Senior senior = seniorService.getSeniorsByUserId(userId);

            model.addAttribute("senior", senior);
            model.addAttribute("center", "user/map");
            return "index";
        } catch (Exception e) {
            return "redirect:/user/senior/insert";
        }
    }

    @GetMapping("/worklog")
    public String worklog(@RequestParam Integer workLogId, HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("principal");
        if (userId == null) {
            return "redirect:/login/user"; // 로그인 페이지로 리다이렉트
        }

        try {
            Senior senior = seniorService.getSeniorsByUserId(userId);
            WorkLog workLog = workLogService.get(workLogId);
            Careworker careworker = careworkerService.get(workLog.getCwId());

            model.addAttribute("senior", senior);
            model.addAttribute("workLog", workLog);
            model.addAttribute("careworker", careworker);
            model.addAttribute("center", "user/senior/worklog");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return "index";
    }
}
