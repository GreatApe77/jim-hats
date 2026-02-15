package com.mateusnavarro77.jim_hats_web_api.memberships.repository;

import java.util.List;

import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mateusnavarro77.jim_hats_web_api.memberships.entity.GymChallengeMembership;
import com.mateusnavarro77.jim_hats_web_api.users.entity.User;

@Repository
public interface GymChallengeMembershipRepository extends JpaRepository<GymChallengeMembership, Long> {

    @EntityGraph(attributePaths = { "gymChallenge", "role" })
    List<GymChallengeMembership> findByUserId(Long userId);
}
