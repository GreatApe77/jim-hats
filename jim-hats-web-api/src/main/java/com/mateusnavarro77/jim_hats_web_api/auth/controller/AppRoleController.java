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

import com.mateusnavarro77.jim_hats_web_api.auth.dto.CreateAppRoleDto;
import com.mateusnavarro77.jim_hats_web_api.auth.entity.AppRole;
import com.mateusnavarro77.jim_hats_web_api.auth.service.AppRoleService;

import jakarta.validation.Valid;
import jakarta.validation.constraints.Min;

@RestController
@RequestMapping("/app-roles")
public class AppRoleController {
    private final AppRoleService appRoleService;

    public AppRoleController(AppRoleService appRoleService) {
        this.appRoleService = appRoleService;
    }

    @GetMapping
    @PreAuthorize("@authorizationService.check(authentication, 'ROLES:READ')")
    public List<AppRole> getAllAppRoles() {
        return this.appRoleService.getAllAppRoles();
    }

    @GetMapping("/{appRoleId}")
    @PreAuthorize("@authorizationService.check(authentication, 'ROLES:READ')")
    public AppRole getAppRoleById(@PathVariable @Min(1) Long appRoleId) {
        return this.appRoleService.getAppRoleById(appRoleId);
    }

    @PostMapping
    @PreAuthorize("@authorizationService.check(authentication, 'ROLES:CREATE')")
    public ResponseEntity<?> createAppRole(@RequestBody @Valid CreateAppRoleDto createAppRoleDto) {
        var appRole = this.appRoleService.createAppRole(createAppRoleDto.appRoleName());
        var uri = ServletUriComponentsBuilder
                .fromCurrentRequest()
                .path("/{id}")
                .buildAndExpand(appRole.getId())
                .toUri();
        return ResponseEntity.created(uri).build();
    }

    @DeleteMapping("/{appRoleId}")
    @PreAuthorize("@authorizationService.check(authentication, 'ROLES:DELETE')")
    public ResponseEntity<?> deleteAppRole(@PathVariable @Min(1) Long appRoleId) {
        this.appRoleService.deleteAppRole(appRoleId);
        return ResponseEntity.noContent().build();
    }
}
