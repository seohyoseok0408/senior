package edu.sm.controller;

import edu.sm.model.Senior;
import edu.sm.model.User;
import edu.sm.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
public class UserController {

    final UserService userService;
    String dir = "user/";

    @RequestMapping("/customer-list")
    public String list(Model model, HttpSession session) throws Exception {
        List<User> user = userService.get();

        model.addAttribute("user", user);

        model.addAttribute("center", dir + "userList");

        return "index";
    }

    @RequestMapping("/customer-detail")
    public String detail(Model model, @RequestParam("id") Integer userId) throws Exception {
        User user = userService.get(userId);
        List<Senior> senior = userService.getSeniorsByUserId(userId);

        model.addAttribute("user", user);
        model.addAttribute("senior", senior);
        model.addAttribute("center", dir + "userDetail");
        return "index";
    }
}
