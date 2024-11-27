package edu.sm.util;

import lombok.extern.slf4j.Slf4j;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@Slf4j
public class HttpSendData {

    public static void send(String url) {
        // 하드코딩된 시니어 데이터
        String[] seniorData = {
                "{\"seniorId\":1,\"systolicBP\":120,\"diastolicBP\":80,\"heartRate\":72,\"temperature\":36.5}",
                "{\"seniorId\":2,\"systolicBP\":130,\"diastolicBP\":85,\"heartRate\":75,\"temperature\":36.8}",
                "{\"seniorId\":3,\"systolicBP\":150,\"diastolicBP\":95,\"heartRate\":85,\"temperature\":37.5}",
                "{\"seniorId\":4,\"systolicBP\":180,\"diastolicBP\":110,\"heartRate\":100,\"temperature\":39.0}"
        };

        HttpClient client = HttpClient.newHttpClient();

        for (String jsonData : seniorData) {
            try {
                // JSON 데이터를 URL 인코딩
                String encodedData = URLEncoder.encode(jsonData, StandardCharsets.UTF_8);

                // GET 요청 생성
                HttpRequest request = HttpRequest.newBuilder()
                        .uri(URI.create(url + "?data=" + encodedData))
                        .GET()
                        .build();

                // 요청 전송 및 응답 처리
                HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
                if (response.statusCode() == 200) {
                    // 데이터 전송 성공 로그
                    log.info("Data sent successfully: {}", jsonData);
                } else {
                    log.warn("Failed to send data. Status code: {}", response.statusCode());
                }
            } catch (Exception e) {
                log.error("Error sending data: {}", e.getMessage());
            }
        }
    }
}
