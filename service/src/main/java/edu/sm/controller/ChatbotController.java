package edu.sm.controller;



import edu.sm.dto.Msg;
import edu.sm.util.ChatBotUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

@Slf4j
@Controller
@RequiredArgsConstructor
public class ChatbotController {

    final SimpMessagingTemplate template;
    @Value("${app.url.chatbot}")
    String url;
    @Value("${app.key.chatbot}")
    String key;
    @MessageMapping("/sendchatbot") // 특정 Id에게 전송
    public void sendchat(Msg msg, SimpMessageHeaderAccessor headerAccessor) throws Exception {
        String id = msg.getSendid();
        String content = msg.getContent1();
        log.info("-------------------------");
        log.info(msg.toString());

        String result = ChatBotUtil.getMsg(url,key, content);
        msg.setContent1(result);

        template.convertAndSend("/sendto/"+id,msg);

    }
}