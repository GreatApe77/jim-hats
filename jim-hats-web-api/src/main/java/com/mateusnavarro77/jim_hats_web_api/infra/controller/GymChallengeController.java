package com.mateusnavarro77.jim_hats_web_api.infra.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mateusnavarro77.jim_hats_web_api.infra.service.GymChallengeService;

@RestController
@RequestMapping("/gym-challenges")
public class GymChallengeController {
    private final GymChallengeService gymChallengeService;

    public GymChallengeController(GymChallengeService gymChallengeService) {
        this.gymChallengeService = gymChallengeService;
    }

    public void createGymChallenge() {
        
    }
}
