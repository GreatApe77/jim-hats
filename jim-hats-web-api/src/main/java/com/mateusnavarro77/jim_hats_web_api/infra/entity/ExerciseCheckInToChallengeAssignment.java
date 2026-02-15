package com.mateusnavarro77.jim_hats_web_api.infra.entity;

import com.mateusnavarro77.jim_hats_web_api.gym_challenges.entity.GymChallenge;

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

@Entity
@Table(name = "exercise_check_in_to_challenge_assigments")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class ExerciseCheckInToChallengeAssignment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "exercise_check_in_id", nullable = false)
    private ExerciseCheckIn exerciseCheckIn;

    @ManyToOne
    @JoinColumn(name = "gym_challenge_id", nullable = false)
    private GymChallenge gymChallenge;
}
