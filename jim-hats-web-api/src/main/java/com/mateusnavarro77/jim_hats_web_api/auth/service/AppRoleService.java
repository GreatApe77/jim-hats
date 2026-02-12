package com.mateusnavarro77.jim_hats_web_api.auth.service;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.mateusnavarro77.jim_hats_web_api.auth.entity.AppRole;
import com.mateusnavarro77.jim_hats_web_api.auth.repository.AppRoleRepository;
import com.mateusnavarro77.jim_hats_web_api.auth.repository.PermissionRepository;
import jakarta.transaction.Transactional;

@Service
public class AppRoleService {

    private final PermissionRepository permissionRepository;
    private final AppRoleRepository appRoleRepository;

    public AppRoleService(AppRoleRepository appRoleRepository, PermissionRepository permissionRepository) {
        this.appRoleRepository = appRoleRepository;
        this.permissionRepository = permissionRepository;
    }

    public List<AppRole> getAllAppRoles() {
        return this.appRoleRepository.findAll();
    }

    public AppRole getAppRoleById(Long appRoleId) {
        return this.appRoleRepository.findById(appRoleId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "App role not found"));
    }

    @Transactional
    public AppRole createAppRole(String appRoleName) {
        if (this.appRoleRepository.findByName(appRoleName).isPresent()) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "App role with the same name already exists");
        }
        var appRole = new AppRole();
        appRole.setName(appRoleName);
        return this.appRoleRepository.save(appRole);
    }

    @Transactional
    public void deleteAppRole(Long appRoleId) {
        if (!this.appRoleRepository.existsById(appRoleId))
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "App role not found");
        this.appRoleRepository.deleteById(appRoleId);
    }

    @Transactional
    public void addPermissionToAppRole(Long appRoleId, String permissionName) {
        var appRole = this.appRoleRepository.findById(appRoleId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "App role not found"));
        var permission = this.permissionRepository.findByName(permissionName)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Permission not found"));
        appRole.getPermissions().add(permission);
        this.appRoleRepository.save(appRole);

    }
}
