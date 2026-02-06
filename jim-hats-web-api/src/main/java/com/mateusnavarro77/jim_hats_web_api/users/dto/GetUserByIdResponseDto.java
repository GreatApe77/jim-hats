package com.mateusnavarro77.jim_hats_web_api.users.dto;

import lombok.Builder;

@Builder
public record GetUserByIdResponseDto(
    Long id,
    String username,
    String email,
    String firstName,
    String lastName,
    String createdAt,
    String updatedAt,
    String profilePictureUrl,
    String systemRole
) {
    
}
