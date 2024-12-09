package edu.sm.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.io.BufferedReader;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;
import java.util.stream.Collectors;
import org.springframework.ui.Model;


@RestController
@Slf4j
@RequestMapping("/iot")
public class IotController {

    private static final String LOG_FILE_PATH = "../logs/senior/senior_health.log";

    @GetMapping("/health/{id}")
    public List<Map<String, Object>> getHealthChartBySeniorId(@PathVariable int id) {
        List<Map<String, Object>> healthData = new ArrayList<>();
        try (BufferedReader reader = Files.newBufferedReader(Paths.get(LOG_FILE_PATH))) {
            healthData = reader.lines()
                    .filter(line -> line.contains("seniorId:" + id + ","))
                    .map(this::parseLogLine)
                    .collect(Collectors.toList());
        } catch (Exception e) {
            log.error("Error reading log file: {}", e.getMessage());
        }
        return healthData;
    }

    // 데이터 처리 엔드포인트
    @PostMapping("/senior")
    public String processSeniorData(@RequestBody Map<String, Object> data) {
        try {
            // 동적 seniorId 처리: 기본값 1
            int seniorId = data.containsKey("seniorId") ? (int) data.get("seniorId") : 1;
            int systolicBP = (int) data.get("systolicBP");
            int diastolicBP = (int) data.get("diastolicBP");
            int heartRate = (int) data.get("heartRate");
            float temperature = Float.parseFloat(data.get("temperature").toString());

            log.info("seniorId:{}, systolicBP:{}, diastolicBP:{}, heartRate:{}, temperature:{}",
                    seniorId, systolicBP, diastolicBP, heartRate, temperature);

            return "Data processed successfully for seniorId: " + seniorId;
        } catch (Exception e) {
            log.error("Error processing data: {}", e.getMessage());
            return "Error processing data: " + e.getMessage();
        }
    }

    // 특정 seniorId에 대한 건강 데이터 가져오기
    @GetMapping("/health/data/{id}")
    public List<Map<String, Object>> getHealthDataForAjax(@PathVariable int id) {

        List<Map<String, Object>> healthData = new ArrayList<>();
        try (BufferedReader reader = Files.newBufferedReader(Paths.get(LOG_FILE_PATH))) {
            healthData = reader.lines()
                    .filter(line -> line.contains("seniorId:" + id + ",")) // seniorId 필터링
                    .map(this::parseLogLine)
                    .collect(Collectors.toList());
        } catch (Exception e) {
            log.error("Error reading log file: {}", e.getMessage());
        }
        return healthData;
    }


    // 로그 데이터를 Map으로 파싱
    private Map<String, Object> parseLogLine(String line) {
        Map<String, Object> data = new HashMap<>();
        try {
            String[] logParts = line.split(" - ");
            if (logParts.length < 2) {
                return data;
            }

            String timestamp = logParts[0].substring(0, 19);
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
                }
            }

            data.put("timestamp", timestamp);
        } catch (Exception e) {
            log.error("Error parsing log line: {}", e.getMessage());
        }
        return data;
    }
}
