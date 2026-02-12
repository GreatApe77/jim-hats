package com.mateusnavarro77.jim_hats_web_api.auth.dto;

import jakarta.validation.constraints.NotEmpty;
import lombok.Builder;

@Builder
public record IncludePermissionInAppRoleRequestDto(
        @NotEmpty String permissionName) {

}
