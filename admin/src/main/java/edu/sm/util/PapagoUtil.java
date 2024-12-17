package edu.sm.util;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

public class PapagoUtil {

    public static String getMsg(String clientId, String clientSecret, String msg, String target) {
        String result = "";
//        String clientId = "4n71tzrc7j";//애플리케이션 클라이언트 아이디값";
//        String clientSecret = "bP08oY5Ti6OqAcemKPx0gYyuZ7AzzJlBdJgw78fT";//애플리케이션 클라이언트 시크릿값";
        try {
            String text = URLEncoder.encode(msg, "UTF-8");
            String apiURL = "https://naveropenapi.apigw.ntruss.com/nmt/v1/translation";
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("POST");
            con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            con.setRequestProperty("X-NCP-APIGW-API-KEY-ID", clientId);
            con.setRequestProperty("X-NCP-APIGW-API-KEY", clientSecret);
            // post request
            String postParams = "source=auto&target="+target+"&text=" + text;
            con.setDoOutput(true);
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            wr.writeBytes(postParams);
            wr.flush();
            wr.close();
            int responseCode = con.getResponseCode();
            BufferedReader br;
            if(responseCode==200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  // 오류 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();
            JSONParser jsonparser = new JSONParser();
            try {
                JSONObject json = (JSONObject)jsonparser.parse(response.toString());
                JSONObject message = (JSONObject)json.get("message");
                JSONObject jresult = (JSONObject)message.get("result");
                result = (String)jresult.get("translatedText");
            } catch (Exception e) {
                System.out.println("error");
                e.printStackTrace();
            }


        } catch (Exception e) {
            System.out.println(e);
        }
        return result;
    }


}
