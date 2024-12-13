package edu.sm.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import edu.sm.model.HealthInfo;
import edu.sm.model.Senior;
import edu.sm.service.SeniorService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

@Controller
@Slf4j
@RequiredArgsConstructor
public class SeniorController {

    final SeniorService seniorService;
    String dir = "senior/";

    @RequestMapping("/senior-list")
    public String list(Model model, HttpSession session) throws Exception {
        List<Senior> seniors = seniorService.get();
        model.addAttribute("seniors", seniors);
        model.addAttribute("center", dir + "seniorList");
        // 이 위로는 잘 작동 되니 건들 지 말것

        List<Map<String, Object>> regionWisePersonCount = seniorService.getRegionWisePersonCount();
        log.info("Region-wise person count: {}", regionWisePersonCount);
        try {
            // ObjectMapper로 JSON 문자열 생성
            ObjectMapper objectMapper = new ObjectMapper();
            String jsonRegionWisePersonCount = objectMapper.writeValueAsString(regionWisePersonCount);
            log.info("Region-wise person count JSON: {}", jsonRegionWisePersonCount);

            // JSON 문자열을 모델에 추가
            model.addAttribute("regionWisePersonCountJson", jsonRegionWisePersonCount);
        } catch (Exception e) {
            log.error("Failed to convert region-wise person count to JSON", e);
        }

        List<Map<String, Object>> ageGroupDistribution = seniorService.getAgeGroupDistribution();
        log.info("Age group distribution: {}", ageGroupDistribution);

        try {
            // ObjectMapper를 사용하여 JSON 문자열 생성
            ObjectMapper objectMapper = new ObjectMapper();
            String jsonAgeGroupDistribution = objectMapper.writeValueAsString(ageGroupDistribution);
            log.info("Age group distribution JSON: {}", jsonAgeGroupDistribution);

            // JSON 문자열을 모델에 추가
            model.addAttribute("ageGroupDistributionJson", jsonAgeGroupDistribution);
        } catch (Exception e) {
            log.error("Failed to convert age group distribution to JSON", e);
        }

        return "index";
    }

    @RequestMapping("/senior-detail")
    public String detail(Model model, @RequestParam("id") Integer seniorId) throws Exception {
        Senior senior = seniorService.get(seniorId);
        List<HealthInfo> healthInfo = seniorService.getHealthInfoBySeniorId(seniorId);

        model.addAttribute("senior", senior);
        model.addAttribute("healthInfo", healthInfo);
        model.addAttribute("center", dir + "seniorDetail");
        // 위에는 건들지 마시오

// 최근 계약 정보
        Map<String, Object> recentContractInfo = seniorService.getRecentContractInfo(seniorId);
        if (recentContractInfo == null || recentContractInfo.isEmpty()) {
            model.addAttribute("recentContractInfo", "정보가 없습니다.");
        } else {
            model.addAttribute("recentContractInfo", recentContractInfo);
        }

// 계약 금액 총합
        Long totalContractAmount = seniorService.getTotalContractAmount(seniorId);
        model.addAttribute("totalContractAmount", totalContractAmount != null ? totalContractAmount : 0L);

// 계약 갱신 횟수
        Long contractRenewalCount = seniorService.getContractRenewalCount(seniorId);
        model.addAttribute("contractRenewalCount", contractRenewalCount != null ? contractRenewalCount : 0L);


        return "index";
    }
}
