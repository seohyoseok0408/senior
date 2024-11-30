package edu.sm.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.io.BufferedReader;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;
import java.util.stream.Collectors;
import org.springframework.ui.Model;

@Controller
@Slf4j
@RequestMapping("/iot")
public class IotController {

    private static final String LOG_FILE_PATH = "../logs/senior/senior_health.log";

    /**
     * Returns health data for a specific senior by ID.
     */
    @GetMapping("/health/{id}")
    public String getHealthChartBySeniorId(@PathVariable int id, Model model) {
        List<Map<String, Object>> healthData = new ArrayList<>();
        try (BufferedReader reader = Files.newBufferedReader(Paths.get(LOG_FILE_PATH))) {
            healthData = reader.lines()
                    .filter(line -> line.contains("seniorId:" + id + ",")) // seniorId 기준 필터링
                    .map(this::parseLogLine) // 로그 라인을 파싱하여 Map으로 변환
                    .collect(Collectors.toList());
        } catch (Exception e) {
            log.error("Error reading log file: {}", e.getMessage());
        }

        log.info("Filtered Health Data for seniorId {}: {}", id, healthData);

        // 데이터를 JSON 문자열로 변환
        String jsonHealthData = "[]"; // 기본값 빈 JSON 배열
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            jsonHealthData = objectMapper.writeValueAsString(healthData);
        } catch (Exception e) {
            log.error("Error converting health data to JSON: {}", e.getMessage());
        }

        model.addAttribute("healthData", jsonHealthData); // JSON 문자열 전달
        model.addAttribute("seniorId", id);              // seniorId 전달
        return "senior/healthchart";                     // JSP 경로
    }


    /**
     * Parses a log line into a map of health data.
     */
    private Map<String, Object> parseLogLine(String line) {
        Map<String, Object> data = new HashMap<>();
        try {
            // 로그 형식: "timestamp - key:value, key:value, ..."
            String[] logParts = line.split(" - ");
            if (logParts.length < 2) {
                log.warn("Invalid log format, skipping line: {}", line);
                return data;
            }

            String timestamp = logParts[0].substring(0, 19); // Extract timestamp
            String[] metrics = logParts[1].split(",");

            for (String metric : metrics) {
                String[] keyValue = metric.split(":");
                if (keyValue.length == 2) {
                    String key = keyValue[0].trim();
                    String value = keyValue[1].trim();

                    if (key.equals("temperature")) {
                        data.put(key, Float.parseFloat(value));
                    } else if (key.matches("systolicBP|diastolicBP|heartRate|seniorId")) {
                        data.put(key, Integer.parseInt(value));
                    }
                } else {
                    log.warn("Invalid metric format, skipping: {}", metric);
                }
            }

            data.put("timestamp", timestamp);

        } catch (Exception e) {
            log.error("Error parsing log line: {}", e.getMessage());
        }
        return data;
    }


    /**
     * Processes health data sent by HttpSendData.
     */
    @PostMapping("/senior")
    public String processSeniorData(@RequestBody Map<String, Object> data) {
        try {
            // 데이터 파싱
            int systolicBP = (int) data.get("systolicBP");
            int diastolicBP = (int) data.get("diastolicBP");
            int heartRate = (int) data.get("heartRate");
            float temperature = Float.parseFloat(data.get("temperature").toString());

            // 건강 상태 로그 출력
            logHealthStatus(systolicBP, diastolicBP, heartRate, temperature);
        } catch (Exception e) {
            log.error("데이터 처리 중 오류 발생: {}", e.getMessage());
        }

        return "Data processed successfully";
    }

    /**
     * Logs health status based on thresholds.
     */
    private void logHealthStatus(int systolicBP, int diastolicBP, int heartRate, float temperature) {
        // Format log message with key:value pairs
        String logMessage = String.format(
                "seniorId:%d, systolicBP:%d, diastolicBP:%d, heartRate:%d, temperature:%.1f",
                1, systolicBP, diastolicBP, heartRate, temperature
        );

        // Log based on health status thresholds
        if (systolicBP < 120 && diastolicBP < 80 && temperature < 37.5) {
            log.info(logMessage);
        } else if (systolicBP < 140 && diastolicBP < 90 && temperature < 38) {
            log.warn(logMessage);
        } else {
            log.error(logMessage);
        }
    }
    @GetMapping("/health/{id}/data")
    @ResponseBody // JSON 데이터를 반환하도록 설정
    public List<Map<String, Object>> getHealthDataForAjax(@PathVariable int id) {
        List<Map<String, Object>> healthData = new ArrayList<>();
        try (BufferedReader reader = Files.newBufferedReader(Paths.get(LOG_FILE_PATH))) {
            healthData = reader.lines()
                    .filter(line -> line.contains("seniorId:" + id + ",")) // seniorId 기준 필터링
                    .map(this::parseLogLine) // 로그 라인을 파싱하여 Map으로 변환
                    .collect(Collectors.toList());
        } catch (Exception e) {
            log.error("Error reading log file: {}", e.getMessage());
        }

        log.info("Filtered Health Data for seniorId {}: {}", id, healthData);
        return healthData; // JSON 반환
    }

}