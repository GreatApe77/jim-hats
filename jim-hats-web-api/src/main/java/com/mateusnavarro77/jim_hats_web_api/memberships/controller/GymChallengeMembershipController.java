package com.mateusnavarro77.jim_hats_web_api.memberships.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mateusnavarro77.jim_hats_web_api.memberships.dto.GetLoggedUserMembershipsDto;
import com.mateusnavarro77.jim_hats_web_api.memberships.dto.GetLoggedUserMembershipsDto.GymChallenge;
import com.mateusnavarro77.jim_hats_web_api.memberships.service.GymChallengeMembershipService;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@RestController()

public class GymChallengeMembershipController {
    private final GymChallengeMembershipService gymChallengeMembershipService;

    public GymChallengeMembershipController(GymChallengeMembershipService gymChallengeMembershipService) {
        this.gymChallengeMembershipService = gymChallengeMembershipService;
    }

    @GetMapping("/users/me/memberships")
    public ResponseEntity<List<GetLoggedUserMembershipsDto>> getLoggedUserGymChallengeMemberships() {
        var authentication = SecurityContextHolder.getContext().getAuthentication();
        var loggedUserId = Long.parseLong(authentication.getName());
        var memberships = gymChallengeMembershipService.getMembershipsByUserId(loggedUserId);
        var formattedToResponse = memberships.stream()
                .map(
                        membership -> GetLoggedUserMembershipsDto.builder()
                                .id(membership.getId())
                                .createdAt(membership.getCreatedAt())
                                .role(membership.getRole().getName())
                                .gymChallenge(
                                        GymChallenge
                                                .builder()
                                                .id(membership.getGymChallenge().getId())
                                                .name(membership.getGymChallenge().getName())
                                                .description(membership.getGymChallenge().getDescription())
                                                .bannerImgUrl(membership.getGymChallenge().getBannerImgUrl())
                                                .build())
                                .build())
                .toList();
        return ResponseEntity.ok().body(formattedToResponse);
    }

}
