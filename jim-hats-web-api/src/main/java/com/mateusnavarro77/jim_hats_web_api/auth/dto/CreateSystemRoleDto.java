package com.mateusnavarro77.jim_hats_web_api.auth.dto;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;
import lombok.Builder;

@Builder
public record CreateSystemRoleDto(
        @NotEmpty @Size(max = 255) String systemRoleName) {

}
