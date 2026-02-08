package com.mateusnavarro77.jim_hats_web_api.auth.service;

import org.springframework.security.core.Authentication;
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

    public boolean check(Authentication auth, String permission) {
        if (auth == null || auth.getAuthorities().isEmpty())
            return false;
        String roleName = auth.getAuthorities().iterator().next().getAuthority();
        return hasSystemLevelPermission(roleName, permission);
    }

}
