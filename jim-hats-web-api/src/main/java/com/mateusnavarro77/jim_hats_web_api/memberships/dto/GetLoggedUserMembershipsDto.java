package com.mateusnavarro77.jim_hats_web_api.memberships.dto;

import java.time.Instant;

import lombok.Builder;

@Builder
public record GetLoggedUserMembershipsDto(
        Long id,
        Instant createdAt,
        String role,
        GymChallenge gymChallenge) {
    @Builder
    public record GymChallenge(
            Long id,
            String name,
            String description,
            String bannerImgUrl) {
    }

}
