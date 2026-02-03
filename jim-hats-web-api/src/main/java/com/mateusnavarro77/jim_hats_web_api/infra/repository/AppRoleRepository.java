package com.mateusnavarro77.jim_hats_web_api.infra.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mateusnavarro77.jim_hats_web_api.infra.entity.AppRole;

@Repository
public interface AppRoleRepository extends JpaRepository<AppRole,Long> {
    
}
