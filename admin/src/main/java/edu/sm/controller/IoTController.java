package edu.sm.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@Slf4j
@RequestMapping("/iot")
public class IoTController {

    private volatile boolean isEmergency = false;
    private volatile Map<String, Object> lastEmergencyData = new HashMap<>();

    // 데이터 처리 엔드포인트
    @PostMapping("/senior")
    public String processSeniorData(@RequestBody Map<String, Object> data) {
        try {
            int seniorId = (int) data.getOrDefault("seniorId", 1);
            int systolicBP = (int) data.get("systolicBP");
            int diastolicBP = (int) data.get("diastolicBP");
            int heartRate = (int) data.get("heartRate");
            float temperature = Float.parseFloat(data.get("temperature").toString());

            log.info("Admin received data -> seniorId:{}, systolicBP:{}, diastolicBP:{}, heartRate:{}, temperature:{}",
                    seniorId, systolicBP, diastolicBP, heartRate, temperature);

            // 비상 상황 감지
            if (isEmergency(systolicBP, diastolicBP, heartRate, temperature)) {
                log.warn("Emergency detected for seniorId: {}", seniorId);
                isEmergency = true;
                lastEmergencyData.put("seniorId", seniorId);
                lastEmergencyData.put("systolicBP", systolicBP);
                lastEmergencyData.put("diastolicBP", diastolicBP);
                lastEmergencyData.put("heartRate", heartRate);
                lastEmergencyData.put("temperature", temperature);
                return "비상상황 발생! 해당 시니어의 바이탈 사인이 정상적이지 않습니다 : " + seniorId;
            } else {
                isEmergency = false;
                lastEmergencyData.clear(); // 비상 상황 데이터 초기화
            }

            return "Data processed successfully for seniorId: " + seniorId;
        } catch (Exception e) {
            log.error("Error processing data: {}", e.getMessage());
            return "Error processing data: " + e.getMessage();
        }
    }

    @GetMapping("/emergency-check")
    public Map<String, Object> checkEmergency() {
        Map<String, Object> response = new HashMap<>();
        response.put("isEmergency", isEmergency);
        if (isEmergency) {
            response.putAll(lastEmergencyData); // 비상 데이터 추가
        }
        log.info("Emergency status checked: {}", isEmergency ? "비상 상황 발생" : "정상");
        return response;
    }

    private boolean isEmergency(int systolicBP, int diastolicBP, int heartRate, float temperature) {
        return systolicBP > 180 || diastolicBP > 120 || heartRate > 120 || temperature < 35.0 || temperature > 38.0;
    }
}
