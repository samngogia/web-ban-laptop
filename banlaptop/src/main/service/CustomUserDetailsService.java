package com.example.springWEB.service;

import java.util.Collections;

import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.example.springWEB.domain.Users;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    private UserService userService;

    public CustomUserDetailsService(UserService userService) {
        this.userService = userService;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        try {
            Users users = this.userService.findUsersByEmail(username);
            if (users == null) {
                throw new UsernameNotFoundException("Not find this user: " + username);
            }
            String roleName = (users.getRoles() != null) ? "ROLE_" + users.getRoles().getName() : "ROLE_USER";
            System.out.println("User " + username + " has role: " + roleName); // Log để debug
            return new User(
                    users.getEmail(),
                    users.getPassword(),
                    Collections.singletonList(new SimpleGrantedAuthority(roleName)));
        } catch (Exception e) {
            System.err.println("Error loading user: " + e.getMessage());
            throw new UsernameNotFoundException("Error loading user: " + e.getMessage());
        }
    }
}