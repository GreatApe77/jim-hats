package com.mateusnavarro77.jim_hats_web_api.domain.services;

public interface PasswordEncrypter {
    String encrypt(String plainTextPassword);
}
