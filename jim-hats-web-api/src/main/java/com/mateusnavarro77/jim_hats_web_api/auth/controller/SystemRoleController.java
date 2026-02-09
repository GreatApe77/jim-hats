package com.mateusnavarro77.jim_hats_web_api.auth.controller;

import java.net.URI;
import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.mateusnavarro77.jim_hats_web_api.auth.dto.CreateSystemRoleDto;
import com.mateusnavarro77.jim_hats_web_api.auth.entity.SystemRole;
import com.mateusnavarro77.jim_hats_web_api.auth.service.SystemRoleService;

import jakarta.validation.Valid;
import jakarta.validation.constraints.Min;

@RestController
@RequestMapping("/system-roles")
public class SystemRoleController {
    private final SystemRoleService systemRoleService;

    public SystemRoleController(SystemRoleService systemRoleService) {
        this.systemRoleService = systemRoleService;
    }

    @GetMapping
    @PreAuthorize("@authorizationService.check(authentication, 'ROLES:READ')")
    public List<SystemRole> getAllSystemRoles() {
        return this.systemRoleService.getAllSystemRoles();
    }

    @GetMapping("/{systemRoleId}")
    @PreAuthorize("@authorizationService.check(authentication, 'ROLES:READ')")
    public SystemRole getSystemRoleById(@PathVariable @Min(1) Long systemRoleId) {
        return this.systemRoleService.getSystemRoleById(systemRoleId);
    }

    @PostMapping
    @PreAuthorize("@authorizationService.check(authentication, 'ROLES:CREATE')")
    public ResponseEntity<?> createSystemRole(@RequestBody @Valid CreateSystemRoleDto createSystemRoleDto) {
        var systemRole = this.systemRoleService.createSystemRole(createSystemRoleDto.systemRoleName());
        var uri = ServletUriComponentsBuilder
                .fromCurrentRequest()
                .path("/{id}")
                .buildAndExpand(systemRole.getId())
                .toUri();
        return ResponseEntity.created(uri).build();
    }
}
