package com.mateusnavarro77.jim_hats_web_api.auth.dto;

import com.mateusnavarro77.jim_hats_web_api.infra.validation.annotations.FirstName;
import com.mateusnavarro77.jim_hats_web_api.infra.validation.annotations.LastName;
import com.mateusnavarro77.jim_hats_web_api.infra.validation.annotations.PlainTextPassword;
import com.mateusnavarro77.jim_hats_web_api.infra.validation.annotations.Username;

import jakarta.validation.constraints.Email;

public record RegisterDto(
        @Username String username,
        @Email String email,
        @PlainTextPassword String password,
        @FirstName String firstName,
        @LastName String lastName) {

}
