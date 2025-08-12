package com.mateusnavarro77.jim_hats_web_api.infra;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.mateusnavarro77.jim_hats_web_api.domain.services.PasswordEncrypter;

public class BCryptPasswordEncrypter implements PasswordEncrypter {
    private final BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

    @Override
    public String encrypt(String password) {
        return encoder.encode(password);
    }
}
