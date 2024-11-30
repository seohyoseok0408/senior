package edu.sm.util;

import lombok.extern.slf4j.Slf4j;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.concurrent.TimeUnit;

@Slf4j
public class HttpSendData {

    private static final DateTimeFormatter TIMESTAMP_FORMAT = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    public static void send(String url) {
        HttpClient client = HttpClient.newHttpClient();

        int counter = 0; // 10초 주기 제어를 위한 카운터
        try {
            while (true) {
                String jsonData;
                if (counter == 0 || counter == 2 || counter == 8) {
                    // 정상 데이터
                    jsonData = generateNormalData();
                    log.info("{} INFO: {}", getCurrentTimestamp(), jsonData);
                } else if (counter == 6) {
                    // 경미한 위험 데이터
                    jsonData = generateMildData();
                    log.warn("{} WARN: {}", getCurrentTimestamp(), jsonData);
                } else if (counter == 10) {
                    // 심각한 위험 데이터
                    jsonData = generateCriticalData();
                    log.error("{} ERROR: {}", getCurrentTimestamp(), jsonData);
                    counter = -2; // 10초 주기 초기화
                } else {
                    jsonData = generateNormalData();
                    log.info("{} INFO: {}", getCurrentTimestamp(), jsonData);
                }

                // HTTP 전송
                sendData(client, url, jsonData);
                TimeUnit.SECONDS.sleep(2); // 2초 대기
                counter += 2;
            }
        } catch (InterruptedException e) {
            log.error("데이터 전송 루프에서 오류 발생: {}", e.getMessage());
            Thread.currentThread().interrupt();
        }
    }

    private static void sendData(HttpClient client, String url, String jsonData) {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(url))
                    .POST(HttpRequest.BodyPublishers.ofString(jsonData))
                    .header("Content-Type", "application/json")
                    .build();

            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

            if (response.statusCode() != 200 && response.statusCode() != 404) {
                log.warn("데이터 전송 실패. 상태 코드: {}, 응답: {}", response.statusCode(), response.body());
            }
        } catch (Exception e) {
            log.error("데이터 전송 중 오류 발생: {}", e.getMessage());
        }
    }

    private static String generateNormalData() {
        return generateData(110, 120, 70, 80, 60, 75, 360, 375);
    }

    private static String generateMildData() {
        // 경미한 위험 데이터에 약간의 변화 추가
        return generateDynamicData(121, 140, 81, 90, 76, 85, 376, 380, 3);
    }

    private static String generateCriticalData() {
        // 심각한 위험 데이터에 큰 변화 추가
        return generateDynamicData(141, 200, 91, 120, 86, 120, 381, 400, 7);
    }

    private static String generateData(int systolicMin, int systolicMax, int diastolicMin, int diastolicMax, int heartRateMin, int heartRateMax, int tempMin, int tempMax) {
        int systolicBP = getRandomValue(systolicMin, systolicMax);
        int diastolicBP = getRandomValue(diastolicMin, diastolicMax);
        int heartRate = getRandomValue(heartRateMin, heartRateMax);
        double temperature = getRandomValue(tempMin, tempMax) / 10.0;

        return String.format("{\"timestamp\":\"%s\",\"seniorId\":1,\"systolicBP\":%d,\"diastolicBP\":%d,\"heartRate\":%d,\"temperature\":%.1f}",
                getCurrentTimestamp(), systolicBP, diastolicBP, heartRate, temperature);
    }

    private static String generateDynamicData(int systolicMin, int systolicMax, int diastolicMin, int diastolicMax, int heartRateMin, int heartRateMax, int tempMin, int tempMax, int variance) {
        int systolicBP = getRandomValue(systolicMin, systolicMax) + getVariance(variance);
        int diastolicBP = getRandomValue(diastolicMin, diastolicMax) + getVariance(variance);
        int heartRate = getRandomValue(heartRateMin, heartRateMax) + getVariance(variance);
        double temperature = (getRandomValue(tempMin, tempMax) + getVariance(variance * 10)) / 10.0;

        return String.format("{\"timestamp\":\"%s\",\"seniorId\":1,\"systolicBP\":%d,\"diastolicBP\":%d,\"heartRate\":%d,\"temperature\":%.1f}",
                getCurrentTimestamp(), systolicBP, diastolicBP, heartRate, temperature);
    }

    private static int getRandomValue(int min, int max) {
        return (int) (Math.random() * (max - min + 1)) + min;
    }

    private static int getVariance(int maxVariance) {
        return (int) (Math.random() * (maxVariance + 1)) - (maxVariance / 2);
    }

    private static String getCurrentTimestamp() {
        return LocalDateTime.now().format(TIMESTAMP_FORMAT);
    }
}
