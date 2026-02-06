package com.mateusnavarro77.jim_hats_web_api.infra.config;

import lombok.Builder;

@Builder
public record JwtUserData(
        Long id,
        String systemRole
) {
}