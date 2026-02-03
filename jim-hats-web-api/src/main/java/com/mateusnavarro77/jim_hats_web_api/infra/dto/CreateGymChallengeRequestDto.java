package com.mateusnavarro77.jim_hats_web_api.infra.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonFormat;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotEmpty;
import lombok.Builder;

@Builder
public record CreateGymChallengeRequestDto(
        @NotEmpty @Max(100) String name,
        @NotEmpty @Max(255) String description,
        @JsonFormat(pattern = "yyyy-MM-dd") LocalDateTime startAt,
        @JsonFormat(pattern = "yyyy-MM-dd") LocalDateTime endAt
        ) {

}
