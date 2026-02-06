package com.mateusnavarro77.jim_hats_web_api.infra.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import com.mateusnavarro77.jim_hats_web_api.auth.entity.SystemRole;
import com.mateusnavarro77.jim_hats_web_api.auth.repository.SystemRoleRepository;
import com.mateusnavarro77.jim_hats_web_api.users.entity.User;
import com.mateusnavarro77.jim_hats_web_api.users.repository.UserRepository;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;


@Component
@RequiredArgsConstructor
public class AdminBootstrap implements ApplicationRunner {

    private final UserRepository userRepository;
    private final SystemRoleRepository systemRoleRepository;
    private final PasswordEncoder passwordEncoder;
    //give default value for admin@email.com
    @Value("${app.bootstrap.admin.email:admin@email.com}")
    private String adminEmail;

    @Value("${app.bootstrap.admin.password:admin}")
    private String adminPassword;

    @Override
    @Transactional
    public void run(ApplicationArguments args) {

        boolean adminExists =
            userRepository.existsBySystemRole_Name("SYSTEM_ADMIN");

        if (adminExists) {
            return;
        }

        User admin = new User();
        admin.setEmail(adminEmail);
        admin.setFirstName("Mateus");
        admin.setLastName("Navarro");
        admin.setUsername("admin");
        admin.setPassword(passwordEncoder.encode(adminPassword));

        SystemRole adminRole =
            systemRoleRepository.findByName("SYSTEM_ADMIN")
                .orElseThrow(() -> new IllegalStateException("SYSTEM_ADMIN role missing"));

        admin.setSystemRole(adminRole);

        userRepository.save(admin);

    }

   
}
