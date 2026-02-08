package com.mateusnavarro77.jim_hats_web_api.auth.service;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.mateusnavarro77.jim_hats_web_api.auth.entity.SystemRole;
import com.mateusnavarro77.jim_hats_web_api.auth.repository.SystemRoleRepository;

@Service
public class SystemRoleService {
    private final SystemRoleRepository systemRoleRepository;

    public SystemRoleService(SystemRoleRepository systemRoleRepository) {
        this.systemRoleRepository = systemRoleRepository;
    }

    public List<SystemRole> getAllSystemRoles() {
        return this.systemRoleRepository.findAll();
    }

    public SystemRole getSystemRoleById(Long systemRoleId) {
        return this.systemRoleRepository.findById(systemRoleId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "System role not found"));
    }
}
