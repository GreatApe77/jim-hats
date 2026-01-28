package com.mateusnavarro77.jim_hats_web_api.infra.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneOffset;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.mateusnavarro77.jim_hats_web_api.infra.entity.User;
import com.mateusnavarro77.jim_hats_web_api.infra.repository.UserRepository;

@Service
public class UserService {
    private final AuthProviderService authProviderService;
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public UserService(
            AuthProviderService authProviderService,
            UserRepository userRepository,
            PasswordEncoder passwordEncoder) {
        this.authProviderService = authProviderService;
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public void register(
            String username,
            String email,
            String plainTextPassword,
            String firstName,
            String lastName

    ) {
        var user = new User();
        user.setUsername(username);
        user.setEmail(email);
        var encryptedPassword = this.passwordEncoder.encode(plainTextPassword);
        user.setPassword(encryptedPassword);
        user.setFirstName(firstName);
        user.setLastName(lastName);
        var now = LocalDate.now();
        user.setCreatedAt(now);
        user.setUpdatedAt(now);

        this.userRepository.save(user);
    }
    public User getUserById(Long userId) {
        return this.userRepository.findById(userId).orElseThrow();
    }
}
