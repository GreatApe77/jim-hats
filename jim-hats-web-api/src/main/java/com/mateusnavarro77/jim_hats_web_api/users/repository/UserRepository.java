package com.mateusnavarro77.jim_hats_web_api.users.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mateusnavarro77.jim_hats_web_api.users.entity.User;


public interface UserRepository extends JpaRepository<User, Long> {
    User findByEmail(String email);
    User findByUsername(String username);
    boolean existsBySystemRole_Name(String roleName);

}
