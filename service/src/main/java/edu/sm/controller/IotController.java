package edu.sm.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@Slf4j
@RequestMapping("/iot")
public class IotController {

    @GetMapping("/senior")
    public String getSeniorData(@RequestParam("data") String data) {
        try {
            // JSON 데이터를 명시적으로 Map<String, Object>로 변환
            ObjectMapper objectMapper = new ObjectMapper();
            Map<String, Object> parsedData = objectMapper.readValue(data, new TypeReference<Map<String, Object>>() {});

            int seniorId = (int) parsedData.get("seniorId");
            int systolicBP = (int) parsedData.get("systolicBP");
            int diastolicBP = (int) parsedData.get("diastolicBP");
            int heartRate = (int) parsedData.get("heartRate");
            float temperature = Float.parseFloat(parsedData.get("temperature").toString());

            // 위험 상태 확인 및 로그 출력
            checkForAlerts(seniorId, systolicBP, diastolicBP, heartRate, temperature);

        } catch (Exception e) {
            log.error("Error processing received data: {}", e.getMessage());
        }

        return "Data processed successfully";
    }

    private void checkForAlerts(int seniorId, int systolicBP, int diastolicBP, int heartRate, float temperature) {
        StringBuilder alertMessage = new StringBuilder();

        if (seniorId == 1 || seniorId == 2) {
            // 정상 상태
            log.info("SeniorID {}: Normal status. SystolicBP: {}, DiastolicBP: {}, HeartRate: {}, Temperature: {}",
                    seniorId, systolicBP, diastolicBP, heartRate, temperature);
        } else if (seniorId == 3) {
            // 경미한 위험 상태
            alertMessage.append(String.format("SeniorID %d: Mild warning. SystolicBP: %d, DiastolicBP: %d, HeartRate: %d, Temperature: %.1f",
                    seniorId, systolicBP, diastolicBP, heartRate, temperature));
            log.warn(alertMessage.toString());
        } else if (seniorId == 4) {
            // 극히 위험 상태
            alertMessage.append(String.format("SeniorID %d: Critical warning. SystolicBP: %d, DiastolicBP: %d, HeartRate: %d, Temperature: %.1f",
                    seniorId, systolicBP, diastolicBP, heartRate, temperature));
            log.error(alertMessage.toString());
        }
    }
}
