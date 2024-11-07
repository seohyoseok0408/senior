package edu.sm.controller;

import edu.sm.model.User;
import edu.sm.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
public class UserController {

    final UserService userService;
    String dir = "user/";

    @RequestMapping("/customer-list")
    public String main(Model model, HttpSession session) throws Exception {
        List<User> user = userService.get();

        // 가져온 데이터 로그 출력
        log.info("Retrieved User List: {}", user);

        model.addAttribute("user", user);
        model.addAttribute("header", "header");
        model.addAttribute("center", dir + "userList");
        model.addAttribute("sidebar", "sidebar");
        return "index";
    }
}
