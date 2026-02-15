package com.mateusnavarro77.jim_hats_web_api.gym_challenges.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mateusnavarro77.jim_hats_web_api.gym_challenges.entity.GymChallenge;

public interface GymChallengeRepository extends JpaRepository<GymChallenge,Long> {
    
}
