package com.mateusnavarro77.jim_hats_web_api.shared.config;

import lombok.Builder;

@Builder
public record ErrorResponseDto(
        String reason,
        int status,
        int timestamp) {

}
