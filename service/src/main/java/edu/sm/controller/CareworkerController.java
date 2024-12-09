package edu.sm.controller;

import edu.sm.model.Careworker;
import edu.sm.model.Senior;
import edu.sm.service.CareworkerService;
import edu.sm.service.ContractService;
import edu.sm.service.SeniorService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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

            model.addAttribute("contractDetails", contractDetails);
            model.addAttribute("center", "careworker/contract_detail");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return "index";
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
    public String senior(HttpSession session, Model model, @RequestParam(required = true) Integer seniorId) {
        Integer cwId = (Integer) session.getAttribute("principal");
        if (cwId == null) {
            return "redirect:/login/careworker"; // 로그인 페이지로 리다이렉트
        }

        try {
            Map<String, Object> contractDetails = contractService.getContractDetails(cwId);

            model.addAttribute("contractDetails", contractDetails);
            model.addAttribute("center", "careworker/senior");
        } catch (Exception e) {
            return "redirect:/";
        }
        return "index";
    }
}
