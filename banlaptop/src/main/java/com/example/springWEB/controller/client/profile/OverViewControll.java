package com.example.springWEB.controller.client.profile;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.example.springWEB.domain.Users;
import com.example.springWEB.domain.dto.ChangePassDTO;
import com.example.springWEB.service.UserService;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpSession;


@Controller
public class OverViewControll {

    public UserService userService;
    public ServletContext servletContext;
    public PasswordEncoder passwordEncoder;

    public OverViewControll(UserService userService, ServletContext servletContext, PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.servletContext = servletContext;
        this.passwordEncoder = passwordEncoder;
    }

   
    @GetMapping("/overView")
    public String getAc(Model model, @AuthenticationPrincipal UserDetails ud) {
        model.addAttribute("ud", this.userService.findUsersByEmail(ud.getUsername()));
        return "/client/profile/overView";
    }

    @GetMapping("/viewAcc")
    public String ViewAcc(Model model, @AuthenticationPrincipal UserDetails userDetails) {
        Users user = this.userService.findUsersByEmail(userDetails.getUsername());
        model.addAttribute("user", user);
        return "/client/profile/viewAcc";
    }

    @GetMapping("/updateAcc")
    public String getUpdateAcc(Model model, @AuthenticationPrincipal UserDetails userDetails,
            @ModelAttribute("updateAcc") Users updatUsers) {
        Users user = this.userService.findUsersByEmail(userDetails.getUsername());
        model.addAttribute("user", user);
        return "/client/profile/updateAcc";
    }

    @PostMapping("/updateAccF")
    public String updateAccFs(Model model, @ModelAttribute("updateAcc") Users updatUsers,
            @AuthenticationPrincipal UserDetails userDetails,
            @RequestParam("fileup") MultipartFile file) {
        Users us = this.userService.findUsersByEmail(userDetails.getUsername());
        us.setFullname(updatUsers.getFullname());
        us.setAddress(updatUsers.getAddress());
        us.setPhone(updatUsers.getPhone());
        String img = "";
        try {
            byte[] bytes;
            bytes = file.getBytes();

            String rootPath = this.servletContext.getRealPath("/resources/images");

            File dir = new File(rootPath + File.separator + "avatar");

            if (!dir.exists()) {
                dir.mkdirs();
            }

            File serverFile = new File(dir.getAbsolutePath() + File.separator
                    + file.getOriginalFilename());

            img = file.getOriginalFilename();

            BufferedOutputStream stream = new BufferedOutputStream(
                    new FileOutputStream(serverFile));

            stream.write(bytes);
            stream.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        us.setAvatar(img);
        this.userService.saveUser(us);
        return "hello";
    }

    @GetMapping("/updatePass")
    public String getUpdatePass(Model model, @ModelAttribute("updatePass") ChangePassDTO dto) {
        return "/client/profile/updatePass";
    }

    @PostMapping("/updatePassF")
    public String postChangePass(Model model, @ModelAttribute("updatePass") ChangePassDTO dto,
            @AuthenticationPrincipal UserDetails userDetails, HttpSession session) {
        Users user = this.userService.findUsersByEmail(userDetails.getUsername());
        String currentPass = user.getPassword();
        if (!this.passwordEncoder.matches(dto.getCurrentPass(), currentPass)) {
            System.out.println("Mat khau sai!!");
            session.setAttribute("errCurrent", "Mật khẩu sai!!");
            return "redirect:/updatePass";
        }
        String newPass = dto.getNewPass();
        String rePass = dto.getRePass();
        if (newPass != null || rePass != null || newPass != null && rePass != null) {
            session.setAttribute("errPass", "Mật khẩu không khớp!!");
            return "redirect:/updatePass";
        }
        if (!newPass.equals(rePass)) {
            System.out.println("Mật khẩu không khớp!!!");
            session.setAttribute("errPass", "Mật khẩu không khớp!!");
            return "redirect:/updatePass";
        }

        user.setPassword(newPass);
        this.userService.saveUser(user);
        return "hello";
    }

}
