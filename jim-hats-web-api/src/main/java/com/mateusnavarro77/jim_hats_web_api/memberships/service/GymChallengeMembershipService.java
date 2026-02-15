package com.mateusnavarro77.jim_hats_web_api.memberships.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.mateusnavarro77.jim_hats_web_api.memberships.entity.GymChallengeMembership;
import com.mateusnavarro77.jim_hats_web_api.memberships.repository.GymChallengeMembershipRepository;

@Service
public class GymChallengeMembershipService {

    private final GymChallengeMembershipRepository gymChallengeMembershipRepository;

    public GymChallengeMembershipService(GymChallengeMembershipRepository gymChallengeMembershipRepository) {
        this.gymChallengeMembershipRepository = gymChallengeMembershipRepository;
    }

    public List<GymChallengeMembership> getMembershipsByUserId(Long userId) {
        return gymChallengeMembershipRepository.findByUserId(userId);
    }
}
