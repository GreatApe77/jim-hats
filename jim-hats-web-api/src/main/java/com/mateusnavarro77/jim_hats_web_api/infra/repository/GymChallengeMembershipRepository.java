package com.mateusnavarro77.jim_hats_web_api.infra.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mateusnavarro77.jim_hats_web_api.infra.entity.GymChallengeMembership;

public interface GymChallengeMembershipRepository extends JpaRepository<GymChallengeMembership, Long> {
    
}
