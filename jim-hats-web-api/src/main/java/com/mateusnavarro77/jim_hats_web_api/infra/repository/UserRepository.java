package com.mateusnavarro77.jim_hats_web_api.infra.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mateusnavarro77.jim_hats_web_api.infra.entity.User;


public interface UserRepository extends JpaRepository<User, Long> {
    User findByEmail(String email);
    User findByUsername(String username);
    
}
