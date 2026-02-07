package com.mateusnavarro77.jim_hats_web_api.auth.service;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.mateusnavarro77.jim_hats_web_api.auth.repository.SystemRoleRepository;

@Service
public class AuthorizationService {
    private final SystemRoleRepository systemRoleRepository;

    public AuthorizationService(SystemRoleRepository systemRoleRepository) {
        this.systemRoleRepository = systemRoleRepository;
    }

    public boolean hasSystemLevelPermission(String systemRoleName, String permissionName) {
        var systemRole = this.systemRoleRepository.findByName(systemRoleName);
        if (systemRole.isEmpty()) {
            return false;
        }
        return systemRole.get()
                .getPermissions()
                .stream()
                .anyMatch(permission -> permission.getName().equals(permissionName));
    }

    

}
