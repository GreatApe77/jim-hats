package com.mateusnavarro77.jim_hats_web_api.auth.dto;

import com.mateusnavarro77.jim_hats_web_api.shared.validation.annotations.PlainTextPassword;
import com.mateusnavarro77.jim_hats_web_api.shared.validation.annotations.Username;

public record LoginRequestDto(
        @Username String username,
        @PlainTextPassword String password) {

}
