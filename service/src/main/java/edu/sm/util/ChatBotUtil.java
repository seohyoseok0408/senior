package edu.sm.util;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import lombok.extern.slf4j.Slf4j;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Base64;
import java.util.Date;

@Slf4j
public class ChatBotUtil {

    public static String getMsg(String apiUrl, String secretKey, String msg) throws Exception {
        URL url = new URL(apiUrl);
        String chatMessage = msg;
        String message = getReqMessage(chatMessage);
        String encodeBase64String = makeSignature(message, secretKey);

        log.info("Chatbot API Request Message: {}", message);
        log.info("Chatbot API Signature: {}", encodeBase64String);

        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("POST");
        con.setRequestProperty("Content-Type", "application/json;UTF-8");
        con.setRequestProperty("X-NCP-CHATBOT_SIGNATURE", encodeBase64String);

        con.setDoOutput(true);
        DataOutputStream wr = new DataOutputStream(con.getOutputStream());

        wr.write(message.getBytes("UTF-8"));
        wr.flush();
        wr.close();

        int responseCode = con.getResponseCode();
        log.info("Chatbot API Response Code: {}", responseCode);

        BufferedReader br;

        if (responseCode == 200) { // 정상 호출
            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
            String decodedString;
            String jsonString = "";
            while ((decodedString = in.readLine()) != null) {
                jsonString = decodedString;
            }

            log.info("Chatbot API Response JSON: {}", jsonString);

            JSONParser jsonparser = new JSONParser();
            try {
                JSONObject json = (JSONObject) jsonparser.parse(jsonString);
                JSONArray bubblesArray = (JSONArray) json.get("bubbles");
                JSONObject bubbles = (JSONObject) bubblesArray.get(0);
                JSONObject data = (JSONObject) bubbles.get("data");
                String description = "";
                description = (String) data.get("description");
                chatMessage = description;
                log.info("Parsed Chatbot Response: {}", chatMessage);
            } catch (Exception e) {
                log.error("Error parsing Chatbot API response", e);
            }

            in.close();

        } else { // 에러 발생
            log.error("Chatbot API Error Response Message: {}", con.getResponseMessage());
            chatMessage = con.getResponseMessage();
        }
        return chatMessage;
    }

    public static String getReqMessage(String voiceMessage) {
        String requestBody = "";

        try {
            JSONObject obj = new JSONObject();

            long timestamp = new Date().getTime();

            log.info("Request Timestamp: {}", timestamp);

            obj.put("version", "v2");
            obj.put("userId", "U47b00b58c90f8e47428af8b7bddc1231heo2");
            obj.put("timestamp", timestamp);

            JSONObject bubbles_obj = new JSONObject();

            bubbles_obj.put("type", "text");

            JSONObject data_obj = new JSONObject();
            data_obj.put("description", voiceMessage);

            bubbles_obj.put("type", "text");
            bubbles_obj.put("data", data_obj);

            JSONArray bubbles_array = new JSONArray();
            bubbles_array.add(bubbles_obj);

            obj.put("bubbles", bubbles_array);
            obj.put("event", "send");

            requestBody = obj.toString();
        } catch (Exception e) {
            log.error("Error creating Chatbot API request message", e);
        }

        return requestBody;
    }

    public static String makeSignature(String message, String secretKey) {
        String encodeBase64String = "";

        try {
            byte[] secrete_key_bytes = secretKey.getBytes("UTF-8");

            SecretKeySpec signingKey = new SecretKeySpec(secrete_key_bytes, "HmacSHA256");
            Mac mac = Mac.getInstance("HmacSHA256");
            mac.init(signingKey);

            byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));
            encodeBase64String = Base64.getEncoder().encodeToString(rawHmac);

            log.info("Generated Signature: {}", encodeBase64String);

            return encodeBase64String;

        } catch (Exception e) {
            log.error("Error generating signature for Chatbot API", e);
        }

        return encodeBase64String;
    }
}
