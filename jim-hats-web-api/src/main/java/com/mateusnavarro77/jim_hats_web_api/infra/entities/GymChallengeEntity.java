package com.mateusnavarro77.jim_hats_web_api.infra.entities;

import java.time.LocalDateTime;
import java.util.List;

import org.hibernate.annotations.CreationTimestamp;

import jakarta.persistence.*;

@Entity
@Table(name = "gym_challenges")
public class GymChallengeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false, length = 255)
    private String name;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String description;

    @Column(length = 255)
    private String image;

    @Column(name = "join_id", unique = true, length = 255)
    private String joinId;

    @CreationTimestamp
    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "start_at", nullable = false)
    private LocalDateTime startAt;

    @Column(name = "end_at", nullable = false)
    private LocalDateTime endAt;

    @Column(name = "creator_id", nullable = false)
    private Integer creatorId;

    @OneToMany(mappedBy = "gymChallenge", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<MembershipEntity> memberships;

    @OneToMany(mappedBy = "gymChallenge", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<ExerciseLogChallengeEntity> exerciseLogs;

    // ===== getters and setters =====

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getJoinId() {
        return joinId;
    }

    public void setJoinId(String joinId) {
        this.joinId = joinId;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public LocalDateTime getStartAt() {
        return startAt;
    }

    public void setStartAt(LocalDateTime startAt) {
        this.startAt = startAt;
    }

    public LocalDateTime getEndAt() {
        return endAt;
    }

    public void setEndAt(LocalDateTime endAt) {
        this.endAt = endAt;
    }

    public Integer getCreatorId() {
        return creatorId;
    }

    public void setCreatorId(Integer creatorId) {
        this.creatorId = creatorId;
    }

    public List<MembershipEntity> getMemberships() {
        return memberships;
    }

    public void setMemberships(List<MembershipEntity> memberships) {
        this.memberships = memberships;
    }

 
}
