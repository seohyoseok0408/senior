package edu.sm.controller;

import edu.sm.model.Message;
import edu.sm.service.MessageService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Slf4j
@RequiredArgsConstructor
@Controller
@RequestMapping("/messages")
public class MessageController {
    private final MessageService messageService;


    @GetMapping("/")
    public String viewMessages(HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("principal");
        if (userId == null) {
            return "redirect:/login";
        }

        try {
            List<Message> messages = messageService.getMessagesByReceiverId(userId);
            model.addAttribute("messages", messages);
            model.addAttribute("center", "messages/list");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return "index";
    }

    @GetMapping("/view")
    public String viewMessageDetail(@RequestParam("messageId") Integer messageId, HttpSession session, Model model) {
        Integer userId = (Integer) session.getAttribute("principal");
        if (userId == null) {
            return "redirect:/login";
        }

        try {
            Message message = messageService.get(messageId);
            model.addAttribute("message", message);
            model.addAttribute("center", "messages/detail");

            if (!message.getReceiverId().equals(userId)) {
                return "redirect:/messages";
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return "index";
    }
}
