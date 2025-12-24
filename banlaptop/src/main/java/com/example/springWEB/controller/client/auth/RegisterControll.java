package com.example.springWEB.controller.client.auth;

import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.springWEB.domain.Users;
import com.example.springWEB.domain.dto.RegisterDTO;
import com.example.springWEB.repository.RolesRepository;
import com.example.springWEB.service.UserService;

import jakarta.transaction.Transactional;

@Controller
public class RegisterControll {

    private UserService userService;
    private RolesRepository rolesRepository;
    private AuthenticationManager authenticationManager;

    public RegisterControll(UserService userService, RolesRepository rolesRepository,
            AuthenticationManager authenticationManager) {
        this.userService = userService;
        this.rolesRepository = rolesRepository;
        this.authenticationManager = authenticationManager;
    }

    @GetMapping("/register")
    public String register(Model model, @ModelAttribute("regisNew") RegisterDTO re) {
        if (!model.containsAttribute("regisNew")) {
            model.addAttribute("regisNew", new RegisterDTO());
        }
        return "client/auth/register";
    }

    @PostMapping("/register")
    @Transactional
    public String registerf(Model model, @ModelAttribute("regisNew") RegisterDTO re,
            RedirectAttributes redirectAttributes) {
        boolean hasError = false;
        String pass = re.getPassword();
        String repass = re.getRepeatPassword();

        if (!pass.equals(repass)) {
            redirectAttributes.addFlashAttribute("showMess", true);
            hasError = true;
            System.out.println("Password mismatch");
        }

        if (this.userService.existsByEmailUser(re.getEmail())) {
            redirectAttributes.addFlashAttribute("emailExist", true);
            hasError = true;
            System.out.println("Email already exists");
        }

        if (hasError) {
            return "redirect:/register";
        }

        try {
            Users user = this.userService.registerDtoToUser(re);
            user.setRoles(this.rolesRepository.findByName("USER")); // Khớp với database
            if (user.getRoles() == null) {
                System.err.println("Role USER not found in database");
                redirectAttributes.addFlashAttribute("error", "Registration failed: Role not found");
                return "redirect:/register";
            }
            this.userService.createUser(user);
            System.out.println("User saved: " + user);

            // Tự động đăng nhập
            UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(
                    re.getEmail(), re.getPassword());
            Authentication authentication = authenticationManager.authenticate(authToken);
            SecurityContextHolder.getContext().setAuthentication(authentication);

            return "redirect:/";
        } catch (Exception e) {
            System.err.println("Error saving user: " + e.getMessage());
            redirectAttributes.addFlashAttribute("error", "Registration failed");
            return "redirect:/register";
        }
    }

    @GetMapping("/login")
    public String login(Model model) {
        return "client/auth/login";
    }

    @GetMapping("/access-deny")
    public String getMethodName(Model model) {
        return "client/auth/access-deny";
    }
}