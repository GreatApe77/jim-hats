package com.mateusnavarro77.jim_hats_web_api.auth.service;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.mateusnavarro77.jim_hats_web_api.auth.entity.Permission;
import com.mateusnavarro77.jim_hats_web_api.auth.repository.PermissionRepository;

import jakarta.transaction.Transactional;

@Service
public class PermissionService {
    private final PermissionRepository permissionRepository;

    public PermissionService(PermissionRepository permissionRepository) {
        this.permissionRepository = permissionRepository;
    }

    public List<Permission> getAllPermissions() {
        return this.permissionRepository.findAll();
    }

    public Permission getPermissionById(Long permissionId) {
        return this.permissionRepository.findById(permissionId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Permission not found"));
    }

    @Transactional
    public Permission createPermission(String permissionName) {
        if (this.permissionRepository.findByName(permissionName).isPresent()) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Permission with the same name already exists");
        }
        var permission = new Permission();
        permission.setName(permissionName);
        return this.permissionRepository.save(permission);
    }

    @Transactional
    public void deletePermission(Long permissionId) {
        if (!this.permissionRepository.existsById(permissionId))
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Permission not found");
        this.permissionRepository.deleteById(permissionId);
    }
}
