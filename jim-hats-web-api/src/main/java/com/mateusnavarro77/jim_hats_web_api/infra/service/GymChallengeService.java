package com.mateusnavarro77.jim_hats_web_api.infra.service;

import java.time.Instant;
import java.time.LocalDateTime;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.mateusnavarro77.jim_hats_web_api.infra.entity.AppRole;
import com.mateusnavarro77.jim_hats_web_api.infra.entity.GymChallenge;
import com.mateusnavarro77.jim_hats_web_api.infra.entity.GymChallengeMembership;
import com.mateusnavarro77.jim_hats_web_api.infra.repository.AppRoleRepository;
import com.mateusnavarro77.jim_hats_web_api.infra.repository.GymChallengeMembershipRepository;
import com.mateusnavarro77.jim_hats_web_api.infra.repository.GymChallengeRepository;
import com.mateusnavarro77.jim_hats_web_api.infra.repository.UserRepository;

import jakarta.transaction.Transactional;

@Service
public class GymChallengeService {
    private final GymChallengeRepository gymChallengeRepository;
    private final AppRoleRepository appRoleRepository;
    private final GymChallengeMembershipRepository gymChallengeMembershipRepository;
    private final UserRepository userRepository;
    public GymChallengeService(GymChallengeRepository gymChallengeRepository, AppRoleRepository appRoleRepository, GymChallengeMembershipRepository gymChallengeMembershipRepository, UserRepository userRepository) {
        this.gymChallengeRepository = gymChallengeRepository;
        this.appRoleRepository = appRoleRepository;
        this.gymChallengeMembershipRepository = gymChallengeMembershipRepository;
        this.userRepository = userRepository;
    }

    @Transactional
    public void createGymChallenge(
        Long creatorId,
        String name,
        String description,
        String bannerImgUrl,
        Instant startAt,
        Instant endAt
    ){
        if(startAt.isAfter(endAt)){
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Start date must be before end date");
        }
        
        var gymChallenge = new GymChallenge();
        gymChallenge.setName(name);
        gymChallenge.setDescription(description);
        gymChallenge.setBannerImgUrl(bannerImgUrl);
        gymChallenge.setStartAt(startAt);
        gymChallenge.setEndAt(endAt);
        gymChallengeRepository.save(gymChallenge);
        var adminRoleId = 1L; 
        var adminRole = this.appRoleRepository.findById(adminRoleId).orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Admin role not found"));
        var creator = this.userRepository.findById(creatorId).orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Creator user not found"));
        var creatorMembership = new GymChallengeMembership();
        creatorMembership.setGymChallenge(gymChallenge);
        creatorMembership.setUser(creator);
        creatorMembership.setRole(adminRole);
        gymChallengeMembershipRepository.save(creatorMembership);
    }
}
