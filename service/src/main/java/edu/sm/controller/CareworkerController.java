package edu.sm.controller;

import edu.sm.model.*;
import edu.sm.service.CareworkerService;
import edu.sm.service.ContractService;
import edu.sm.service.SeniorService;
import edu.sm.service.WorkLogService;
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
import java.util.Map;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/careworker")
public class CareworkerController {
    private final SeniorService seniorService;
    private final CareworkerService careworkerService;
    private final ContractService contractService;
    private final WorkLogService workLogService;

    @RequestMapping("/mypage")
    public String mypage(HttpSession session, Model model) {
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

    @GetMapping("/contracts")
    public String viewContracts(
            HttpSession session,
            @RequestParam(required = false, defaultValue = "") String status,
            Model model) {
        Integer cwId = (Integer) session.getAttribute("principal");
        if (cwId == null) {
            return "redirect:/login/careworker";
        }

        try {
            List<Map<String, Object>> contractsWithDetails = contractService.getContractsWithDetails(cwId, status);
            model.addAttribute("contractsWithDetails", contractsWithDetails);
            model.addAttribute("status", status); // 현재 상태를 전달하여 탭 활성화에 사용
            model.addAttribute("center", "careworker/contract");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return "index";
    }

    @GetMapping("/contract")
    public String viewContract(@RequestParam Integer contractId, Model model, HttpSession session) {
        Integer cwId = (Integer) session.getAttribute("principal");
        if (cwId == null) {
            return "redirect:/login/careworker";
        }

        try {
            Map<String, Object> contractDetails = contractService.getContractDetails(contractId);
            log.info(contractDetails.toString());
            model.addAttribute("contractDetails", contractDetails);
            model.addAttribute("center", "careworker/contract_detail");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return "index";
    }

    @RequestMapping("/chart/{id}")
    public String chart(@PathVariable Integer id, Model model) {
        // id 값이 JSP에서 차트 렌더링에 사용됩니다.
        model.addAttribute("seniorId", id);
        model.addAttribute("center", "senior/healthchart");
        return "index"; // index.jsp를 사용하여 공통 레이아웃 렌더링
    }

    @RequestMapping("/map")
    public String mapList(HttpSession session, Model model) {
        Integer cwId = (Integer) session.getAttribute("principal");
        if (cwId == null) {
            return "redirect:/login/careworker"; // 로그인 페이지로 리다이렉트
        }
        try {
            Careworker careworker = careworkerService.get(cwId);
            List<Map<String, Object>> contractsWithDetails = contractService.getContractsWithDetails(cwId, "ACTIVE");
            log.info("careworker: {}", careworker);
            log.info("contractsWithDetails: {}", contractsWithDetails);
            model.addAttribute("careworker", careworker);
            model.addAttribute("contractsWithDetails", contractsWithDetails);
            model.addAttribute("center", "careworker/map");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return "index";
    }

    @GetMapping("/seniors")
    public String seniors(HttpSession session, Model model) {
        Integer cwId = (Integer) session.getAttribute("principal");
        if (cwId == null) {
            return "redirect:/login/careworker"; // 로그인 페이지로 리다이렉트
        }

        try {
            List<Map<String, Object>> contractsWithDetails = contractService.getContractsWithDetails(cwId, "ACTIVE");

            model.addAttribute("contractsWithDetails", contractsWithDetails);
            model.addAttribute("center", "careworker/seniors");
        } catch (Exception e) {
            return "redirect:/";
        }

        return "index";
    }

    @GetMapping("/seniors/detail")
    public String senior(HttpSession session, Model model, @RequestParam(required = true) Integer contractId) {
        Integer cwId = (Integer) session.getAttribute("principal");
        if (cwId == null) {
            return "redirect:/login/careworker"; // 로그인 페이지로 리다이렉트
        }

        try {
            Map<String, Object> contractDetails = contractService.getContractDetails(contractId);
            Senior senior = (Senior) contractDetails.get("senior");
            List<WorkLog> workLogs = workLogService.getBySeniorId(senior.getSeniorId());
            log.info(senior.toString());
            model.addAttribute("workLogs", workLogs);
            model.addAttribute("contractDetails", contractDetails);
            model.addAttribute("center", "careworker/senior");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return "index";
    }

    @RequestMapping("/rtc")
    public String video(@RequestParam Integer userId, Model model, HttpSession session) {
        Integer cwid = (Integer) session.getAttribute("principal");
        if (cwid == null) {
            return "redirect:/";
        }

        try {
            Contract contract = contractService.getContractByCwIdUserId(cwid, userId);
            Integer contractId = contract.getContractId();
            Careworker careworker = careworkerService.get(cwid);

            model.addAttribute("user", careworker);
            model.addAttribute("contractId", contractId);
            model.addAttribute("center", "video");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return "index";
    }
    @GetMapping("/worklog")
    public String workLogDetail(HttpSession session, Model model, @RequestParam(required = true) Integer workLogId) {
        Integer cwId = (Integer) session.getAttribute("principal");
        if (cwId == null) {
            return "redirect:/login/careworker"; // 로그인 페이지로 리다이렉트
        }

        try {
            WorkLog workLog = workLogService.get(workLogId);

            model.addAttribute("workLog", workLog);
            model.addAttribute("center", "careworker/worklog");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return "index";
    }

}
