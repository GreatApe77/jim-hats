package com.mateusnavarro77.jim_hats_web_api.infra.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "memberships", uniqueConstraints = {
        @UniqueConstraint(columnNames = { "user_id", "gym_challenge_id" })
})
public class MembershipEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private UserEntity user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "gym_challenge_id", nullable = false)
    private GymChallengeEntity gymChallenge;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private MembershipRole role;

    // ===== getters and setters =====

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public UserEntity getUser() {
        return user;
    }

    public void setUser(UserEntity user) {
        this.user = user;
    }

    public GymChallengeEntity getGymChallenge() {
        return gymChallenge;
    }

    public void setGymChallenge(GymChallengeEntity gymChallenge) {
        this.gymChallenge = gymChallenge;
    }

    public MembershipRole getRole() {
        return role;
    }

    public void setRole(MembershipRole role) {
        this.role = role;
    }
}
