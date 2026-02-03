package com.mateusnavarro77.jim_hats_web_api.infra.dto;

import com.mateusnavarro77.jim_hats_web_api.infra.validation.annotations.PlainTextPassword;
import com.mateusnavarro77.jim_hats_web_api.infra.validation.annotations.Username;

public record LoginRequestDto(
        @Username String username,
        @PlainTextPassword String password) {

}
