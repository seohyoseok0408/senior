package edu.sm.controller;

import edu.sm.dto.Msg;
import edu.sm.util.PapagoUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import java.util.HashMap;
import java.util.Map;

@Slf4j
@Controller
public class MsgController {
    @Autowired
    SimpMessagingTemplate template;

    @Value("${app.key.papago-id}")
    String clientId;
    @Value("${app.key.papago-secret}")
    String clientSecret;

    Map<String, String> userLanguages = new HashMap<String, String>();

    @MessageMapping("/receiveto")
    public void receiveto(Msg msg, SimpMessageHeaderAccessor headerAccessor) {
        String senderId = msg.getSendid();
        String receiverId = msg.getReceiveid();
        String originalText = msg.getContent1();
        String userLanguage = msg.getLanguage(); // 클라이언트 언어 설정
        log.info("Sender: {}, Receiver: {}", senderId, receiverId);

        if (originalText == null || originalText.trim().isEmpty()) {
            log.error("Content1 is null or empty. Cannot process translation.");
            return;
        }
        String translatedText;

        if ("USER".equals(msg.getRole())) { // 사용자 -> 관리자
            if ("en".equals(userLanguage)) {
                log.info("Translating from EN to KO for admin.");
                if (!userLanguages.containsKey(msg.getSendid())) {
                    userLanguages.put(msg.getSendid(), userLanguage);
                }
                translatedText = PapagoUtil.getMsg(clientId, clientSecret, originalText, "ko");
            } else {
                log.info("User sent a message in KO. Sending without translation.");
                translatedText = originalText; // 번역하지 않음
            }
        } else if ("ADMIN".equals(msg.getRole())) { // 관리자 -> 사용자
            if ("en".equals(userLanguages.get(msg.getReceiveid()))) {
                log.info("Translating from KO to EN for user.");
                translatedText = PapagoUtil.getMsg(clientId, clientSecret, originalText, "en");
            } else {
                log.info("User language is KO. Sending original text.");
                translatedText = originalText; // 번역하지 않음
            }
        } else {
            log.warn("Unknown role. Sending original text.");
            translatedText = originalText;
        }

        msg.setContent1(translatedText);
        log.info("Final Translated Message: {}", translatedText);

        // 메시지 전송
        template.convertAndSend("/send/to/" + receiverId, msg);
    }
}

//@MessageMapping("/receiveto") // 특정 Id에게 전송
//public void receiveto(Msg msg, SimpMessageHeaderAccessor headerAccessor) {
//    String id = msg.getSendid();
//    String target = msg.getReceiveid();
//    log.info("-------------------------");
//    log.info(target);
//    String txt = msg.getContent1();
//    String tmsg = PapagoUtil.getMsg(clientId,clientSecret,txt,"ko");
//    msg.setContent1(tmsg);
//    template.convertAndSend("/send/to/"+target,msg);
//}
//}