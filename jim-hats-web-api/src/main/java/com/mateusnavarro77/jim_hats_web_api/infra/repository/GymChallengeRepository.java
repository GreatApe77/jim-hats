package com.mateusnavarro77.jim_hats_web_api.infra.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mateusnavarro77.jim_hats_web_api.infra.entity.GymChallenge;

public interface GymChallengeRepository extends JpaRepository<GymChallenge,Long> {
    
}
