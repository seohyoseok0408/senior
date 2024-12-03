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

    public static void send(String url, int seniorId) {
        HttpClient client = HttpClient.newHttpClient();
        int counter = 0;

        try {
            while (true) {
                String jsonData;

                if (counter % 30 == 0) {
                    jsonData = generateCriticalData(seniorId);
                    log.error("{} CRITICAL: {}", getCurrentTimestamp(), jsonData);
                } else if (counter % 15 == 0) {
                    jsonData = generateMildData(seniorId);
                    log.warn("{} MILD: {}", getCurrentTimestamp(), jsonData);
                } else {
                    jsonData = generateNormalData(seniorId);
                    log.info("{} NORMAL: {}", getCurrentTimestamp(), jsonData);
                }

                sendData(client, url, jsonData);
                TimeUnit.SECONDS.sleep(2);
                counter += 2;
            }
        } catch (InterruptedException e) {
            log.error("Data transmission interrupted: {}", e.getMessage());
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
                log.warn("Failed to send data. Status code: {}, Response: {}", response.statusCode(), response.body());
            }
        } catch (Exception e) {
            log.error("Error during data transmission: {}", e.getMessage());
        }
    }

    private static String generateNormalData(int seniorId) {
        return generateData(seniorId, 110, 120, 70, 80, 60, 75, 360, 375);
    }

    private static String generateMildData(int seniorId) {
        return generateDynamicData(seniorId, 121, 140, 81, 90, 76, 85, 376, 380, 3);
    }

    private static String generateCriticalData(int seniorId) {
        return generateDynamicData(seniorId, 141, 200, 91, 120, 86, 120, 381, 400, 7);
    }

    private static String generateData(int seniorId, int systolicMin, int systolicMax, int diastolicMin, int diastolicMax, int heartRateMin, int heartRateMax, int tempMin, int tempMax) {
        // 기본값 설정
        if (seniorId <= 0) {
            seniorId = 1; // default 값
        }

        int systolicBP = getRandomValue(systolicMin, systolicMax);
        int diastolicBP = getRandomValue(diastolicMin, diastolicMax);
        int heartRate = getRandomValue(heartRateMin, heartRateMax);
        double temperature = getRandomValue(tempMin, tempMax) / 10.0;

        return String.format("{\"timestamp\":\"%s\",\"seniorId\":%d,\"systolicBP\":%d,\"diastolicBP\":%d,\"heartRate\":%d,\"temperature\":%.1f}",
                getCurrentTimestamp(), seniorId, systolicBP, diastolicBP, heartRate, temperature);
    }

    private static String generateDynamicData(int seniorId, int systolicMin, int systolicMax, int diastolicMin, int diastolicMax, int heartRateMin, int heartRateMax, int tempMin, int tempMax, int variance) {
        // 기본값 설정
        if (seniorId <= 0) {
            seniorId = 1; // default 값
        }

        int systolicBP = getRandomValue(systolicMin, systolicMax) + getVariance(variance);
        int diastolicBP = getRandomValue(diastolicMin, diastolicMax) + getVariance(variance);
        int heartRate = getRandomValue(heartRateMin, heartRateMax) + getVariance(variance);
        double temperature = (getRandomValue(tempMin, tempMax) + getVariance(variance * 10)) / 10.0;

        return String.format("{\"timestamp\":\"%s\",\"seniorId\":%d,\"systolicBP\":%d,\"diastolicBP\":%d,\"heartRate\":%d,\"temperature\":%.1f}",
                getCurrentTimestamp(), seniorId, systolicBP, diastolicBP, heartRate, temperature);
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
