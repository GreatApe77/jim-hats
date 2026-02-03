package com.mateusnavarro77.jim_hats_web_api.infra.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneOffset;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mateusnavarro77.jim_hats_web_api.infra.dto.CreateGymChallengeRequestDto;
import com.mateusnavarro77.jim_hats_web_api.infra.service.GymChallengeService;

import org.springframework.web.bind.annotation.RequestBody; // Correct import
import jakarta.validation.Valid;

@RestController
@RequestMapping("/gym-challenges")
public class GymChallengeController {
    private final GymChallengeService gymChallengeService;

    public GymChallengeController(GymChallengeService gymChallengeService) {
        this.gymChallengeService = gymChallengeService;
    }

    @PostMapping
    public ResponseEntity<Void> createGymChallenge(@RequestBody @Valid CreateGymChallengeRequestDto request) {
        var userId = (Long) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        gymChallengeService.createGymChallenge(userId,
                request.name(),
                request.description(),
                request.bannerImgUrl(),
                
                request.startAt().atStartOfDay(ZoneOffset.UTC).toInstant(),
                request.endAt().atStartOfDay(ZoneOffset.UTC).toInstant());
        
        return ResponseEntity.ok().build();
    }
}
