package com.mateusnavarro77.jim_hats_web_api.users.service;

import java.time.Instant;
import java.time.LocalDate;
import java.util.List;

import org.springframework.data.domain.PageRequest;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.mateusnavarro77.jim_hats_web_api.auth.entity.SystemRole;
import com.mateusnavarro77.jim_hats_web_api.auth.service.AuthProviderService;
import com.mateusnavarro77.jim_hats_web_api.users.entity.User;
import com.mateusnavarro77.jim_hats_web_api.users.repository.UserRepository;

@Service
public class UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public UserService(
            AuthProviderService authProviderService,
            UserRepository userRepository,
            PasswordEncoder passwordEncoder) {
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
        var  systemRole = new SystemRole();
        systemRole.setId(2L); // 2L is the id of the MEMBER role in the database
        user.setSystemRole(systemRole);
        var now = Instant.now();
        user.setUpdatedAt(now);

        this.userRepository.save(user);
    }
    public User getUserById(Long userId) {
        return this.userRepository.findById(userId).orElseThrow();
    }
    public List<User> getAllUsers(int page, int size) {
        var pageable = PageRequest.of(page, size);
        return this.userRepository.findAll(pageable).getContent();
    }
}
