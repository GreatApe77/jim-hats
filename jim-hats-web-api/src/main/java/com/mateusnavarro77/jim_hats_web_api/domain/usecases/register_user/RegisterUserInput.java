package com.mateusnavarro77.jim_hats_web_api.domain.usecases.register_user;

public record RegisterUserInput(
    String username,
    String email,
    String plainTextPassword
) {

}
