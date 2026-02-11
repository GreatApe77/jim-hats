package com.mateusnavarro77.jim_hats_web_api.auth.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.mateusnavarro77.jim_hats_web_api.auth.dto.CreatePermissionDto;
import com.mateusnavarro77.jim_hats_web_api.auth.entity.Permission;
import com.mateusnavarro77.jim_hats_web_api.auth.service.PermissionService;

import jakarta.validation.Valid;
import jakarta.validation.constraints.Min;

@RestController
@RequestMapping("/permissions")
public class PermissionController {
    private final PermissionService permissionService;

    public PermissionController(PermissionService permissionService) {
        this.permissionService = permissionService;
    }

    @GetMapping
    @PreAuthorize("@authorizationService.check(authentication, 'PERMISSIONS:READ')")
    public List<Permission> getAllPermissions() {
        return this.permissionService.getAllPermissions();
    }

    @GetMapping("/{permissionId}")
    @PreAuthorize("@authorizationService.check(authentication, 'PERMISSIONS:READ')")
    public Permission getPermissionById(@PathVariable @Min(1) Long permissionId) {
        return this.permissionService.getPermissionById(permissionId);
    }

    @PostMapping
    @PreAuthorize("@authorizationService.hasSystemRole(authentication, 'SYSTEM_ADMIN')")
    public ResponseEntity<?> createPermission(@RequestBody @Valid CreatePermissionDto createPermissionDto) {
        var permission = this.permissionService.createPermission(createPermissionDto.permissionName());
        var uri = ServletUriComponentsBuilder
                .fromCurrentRequest()
                .path("/{id}")
                .buildAndExpand(permission.getId())
                .toUri();
        return ResponseEntity.created(uri).build();
    }

    @DeleteMapping("/{permissionId}")
    @PreAuthorize("@authorizationService.hasSystemRole(authentication, 'SYSTEM_ADMIN')")
    public ResponseEntity<?> deletePermission(@PathVariable @Min(1) Long permissionId) {
        this.permissionService.deletePermission(permissionId);
        return ResponseEntity.noContent().build();
    }
}
