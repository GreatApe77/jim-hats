package com.mateusnavarro77.jim_hats_web_api.infra.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.Instant;
import java.time.LocalDate;

import org.hibernate.annotations.CreationTimestamp;

import com.mateusnavarro77.jim_hats_web_api.auth.entity.AppRole;
import com.mateusnavarro77.jim_hats_web_api.users.entity.User;

@Entity
@Table(name = "gym_challenge_memberships")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class GymChallengeMembership {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne
    @JoinColumn(name = "gym_challenge_id", nullable = false)
    private GymChallenge gymChallenge;

    @ManyToOne
    @JoinColumn(name = "role_id", nullable = false)
    private AppRole role;

    @Column(name = "created_at", nullable = false)
    @CreationTimestamp
    private Instant createdAt;
}
