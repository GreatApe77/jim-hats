package com.mateusnavarro77.jim_hats_web_api.auth.dto;

import lombok.Builder;

@Builder
public record JwtUserData(
                Long id,
                String systemRole) {
}