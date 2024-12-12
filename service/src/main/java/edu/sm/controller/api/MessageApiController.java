package edu.sm.controller.api;

import edu.sm.dto.ResponseDto;
import edu.sm.model.Message;
import edu.sm.service.MessageService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/api/messages")
public class MessageApiController {
    private final MessageService messageService;

    @GetMapping("/list")
    public List<Message> getMessages(HttpSession session) {
        Integer userId = (Integer) session.getAttribute("principal");
        if (userId == null) {
            throw new IllegalStateException("로그인이 필요합니다.");
        }

        List<Message> messages = null;
        try {
            messages = messageService.getMessagesByReceiverId(userId);
            log.info("messages: {}", messages);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return messages;
    }

    @GetMapping("/detail")
    public Message getMessageDetail(@RequestParam("messageId") Integer messageId, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("principal");
        if (userId == null) {
            throw new IllegalStateException("로그인이 필요합니다.");
        }

        Message message = null;
        try {
            message = messageService.get(messageId);
            log.info(message.toString());
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        if (!message.getReceiverId().equals(userId)) {
            throw new IllegalStateException("해당 메시지를 볼 권한이 없습니다.");
        }
        return message;
    }

    @GetMapping("/unread-count")
    public long getUnreadMessageCount(HttpSession session) {
        Integer userId = (Integer) session.getAttribute("principal");
        if (userId == null) {
            throw new IllegalStateException("로그인이 필요합니다.");
        }

        int count = 0;
        try {
            count = messageService.countUnreadMessages(userId);
            log.info("unread count: {}", count);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return count;
    }

    @PostMapping("/mark-as-read")
    public ResponseDto<Integer> markAsRead(@RequestParam Integer messageId) {
        log.info("aoignaonoeweowig");
        try {
            messageService.markAsRead(messageId);
            return new ResponseDto<>(HttpStatus.OK.value(), 1);

        } catch (Exception e) {
            return new ResponseDto<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), 0);
        }
    }


}
