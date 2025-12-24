package com.example.springWEB.config;

import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.example.springWEB.domain.Users;
import com.example.springWEB.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class CustomSuccessHandlers implements AuthenticationSuccessHandler {

    @Autowired
    private UserService userService;

    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

    protected String determineTargetUrl(final Authentication authentication) {
        Map<String, String> roleTargetUrlMap = new HashMap<>();
        roleTargetUrlMap.put("ROLE_USER", "/");
        roleTargetUrlMap.put("ROLE_ADMIN", "/adminDash");

        final Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
        for (final GrantedAuthority grantedAuthority : authorities) {
            String authorityName = grantedAuthority.getAuthority();
            System.out.println("User authority: " + authorityName); // Log để debug
            if (roleTargetUrlMap.containsKey(authorityName)) {
                return roleTargetUrlMap.get(authorityName);
            }
        }
        System.out.println("No matching role found, redirecting to /");
        return "/"; // Trả về trang chủ mặc định
    }

    protected void handle(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
            throws IOException {
        String targetUrl = determineTargetUrl(authentication);

        if (response.isCommitted()) {
            return;
        }

        redirectStrategy.sendRedirect(request, response, targetUrl);
    }

    protected void clearAuthenticationAttributes(HttpServletRequest request, Authentication authentication) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return;
        }
        session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
        String email = authentication.getName();
        try {
            Users user = userService.findUsersByEmail(email);
            if (user != null) {
                session.setAttribute("fullName", user.getFullname() != null ? user.getFullname() : "");
                session.setAttribute("avatar", user.getAvatar() != null ? user.getAvatar() : "");
                session.setAttribute("id", user.getId());
                session.setAttribute("email", user.getEmail());
                int sum = (user.getCart() != null) ? user.getCart().getCartDetail().size() : 0;
                session.setAttribute("sum", sum);
            } else {
                System.out.println("User not found for email: " + email);
            }
        } catch (Exception e) {
            System.err.println("Error fetching user: " + e.getMessage());
        }
    }

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
            Authentication authentication) throws IOException, ServletException {
        clearAuthenticationAttributes(request, authentication); // Gọi trước redirect
        handle(request, response, authentication);
    }
}