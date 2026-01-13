package com.mateusnavarro77.jim_hats_web_api.infra.entities;

import jakarta.persistence.*;

@Entity
@Table(
    name = "exercise_log_challenges",
    uniqueConstraints = {
        @UniqueConstraint(columnNames = {"exercise_log_id", "gym_challenge_id"})
    }
)
public class ExerciseLogChallengeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "exercise_log_id", nullable = false)
    private ExerciseLogEntity exerciseLog;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "gym_challenge_id", nullable = false)
    private GymChallengeEntity gymChallenge;

    // ===== getters & setters =====

    public Integer getId() {
        return id;
    }

    public ExerciseLogEntity getExerciseLog() {
        return exerciseLog;
    }

    public void setExerciseLog(ExerciseLogEntity exerciseLog) {
        this.exerciseLog = exerciseLog;
    }

    public GymChallengeEntity getGymChallenge() {
        return gymChallenge;
    }

    public void setGymChallenge(GymChallengeEntity gymChallenge) {
        this.gymChallenge = gymChallenge;
    }
}
