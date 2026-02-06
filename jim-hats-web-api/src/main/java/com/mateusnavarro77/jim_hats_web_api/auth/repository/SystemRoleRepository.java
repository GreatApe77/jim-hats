package com.mateusnavarro77.jim_hats_web_api.auth.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mateusnavarro77.jim_hats_web_api.auth.entity.SystemRole;


@Repository
public interface SystemRoleRepository extends JpaRepository<SystemRole,Long> {
    Optional<SystemRole> findByName(String name);
}
