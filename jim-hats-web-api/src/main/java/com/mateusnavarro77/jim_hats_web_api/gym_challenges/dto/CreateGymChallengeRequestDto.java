package com.mateusnavarro77.jim_hats_web_api.gym_challenges.dto;

import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonFormat;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;
import lombok.Builder;

@Builder
public record CreateGymChallengeRequestDto(
                @NotEmpty @Size(min = 1, max = 50) String name,
                @NotEmpty @Size(max = 255) String description,
                @NotEmpty @Size(max = 255) String bannerImgUrl,
                @JsonFormat(pattern = "yyyy-MM-dd") LocalDate startAt,
                @JsonFormat(pattern = "yyyy-MM-dd") LocalDate endAt) {

}
