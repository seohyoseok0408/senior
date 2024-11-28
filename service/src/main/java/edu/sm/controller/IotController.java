package edu.sm.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.io.BufferedReader;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;
import java.util.stream.Collectors;

@RestController
@Slf4j
@RequestMapping("/iot")
public class IotController {

    private static final String LOG_FILE_PATH = "../logs/senior/senior_health.log";

    /**
     * Returns health data for a specific senior by ID.
     */
    @GetMapping("/health/{id}")
    public List<Map<String, Object>> getHealthDataBySeniorId(@PathVariable int id) {
        List<Map<String, Object>> healthData = new ArrayList<>();
        try (BufferedReader reader = Files.newBufferedReader(Paths.get(LOG_FILE_PATH))) {
            // Filter logs for specific Senior ID
            healthData = reader.lines()
                    .filter(line -> line.contains("seniorId=" + id + ","))
                    .map(this::parseLogLine)
                    .collect(Collectors.toList());
        } catch (Exception e) {
            log.error("Error reading log file: {}", e.getMessage());
        }
        return healthData;
    }

    /**
     * Parses a log line into a map of health data.
     */
    private Map<String, Object> parseLogLine(String line) {
        Map<String, Object> data = new HashMap<>();
        try {
            String[] logParts = line.split(" - ");
            String timestamp = logParts[0].substring(0, 19); // Extract timestamp
            String[] metrics = logParts[1].split(",");

            for (String metric : metrics) {
                String[] keyValue = metric.split("=");
                String key = keyValue[0].trim();
                String value = keyValue[1].trim();

                if (key.equals("temperature")) {
                    data.put(key, Float.parseFloat(value));
                } else {
                    data.put(key, Integer.parseInt(value));
                }
            }

            // Add timestamp to the data
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
        // Format log message
        String logMessage = String.format(
                "seniorId=1, systolicBP=%d, diastolicBP=%d, heartRate=%d, temperature=%.1f",
                systolicBP, diastolicBP, heartRate, temperature
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
}
