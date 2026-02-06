package com.mateusnavarro77.jim_hats_web_api.users.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.mateusnavarro77.jim_hats_web_api.infra.dto.GetUserByIdResponseDto;
import com.mateusnavarro77.jim_hats_web_api.users.service.UserService;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
// GET    /users/me
// GET    /users/:id            (SYSTEM_ADMIN) Faltando access control
// GET    /users                (SYSTEM_ADMIN)

@RestController
@RequestMapping("/users")
public class UserController {
    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/{userId}")
    public ResponseEntity<GetUserByIdResponseDto> getUserById(@PathVariable Long userId) {
        var user = this.userService.getUserById(userId);
        var responseDto = GetUserByIdResponseDto.builder()
                .id(user.getId())
                .username(user.getUsername())
                .email(user.getEmail())
                .firstName(user.getFirstName())
                .lastName(user.getLastName())
                .createdAt(user.getCreatedAt().toString())
                .updatedAt(user.getUpdatedAt().toString())
                .profilePictureUrl(user.getProfilePictureUrl())
                .build();
        return ResponseEntity.ok(responseDto);
    }

    @GetMapping()
    public ResponseEntity<List<GetUserByIdResponseDto>> getAllUsers(
            @RequestParam(defaultValue = "0") @Min(0) int page,
            @RequestParam(defaultValue = "100") @Min(1) @Max(200) int size) {
        var users = this.userService.getAllUsers(page, size);
        var response = users.stream().map(user -> GetUserByIdResponseDto.builder()
                .id(user.getId())
                .username(user.getUsername())
                .email(user.getEmail())
                .firstName(user.getFirstName())
                .lastName(user.getLastName())
                .createdAt(user.getCreatedAt().toString())
                .updatedAt(user.getUpdatedAt().toString())
                .profilePictureUrl(user.getProfilePictureUrl())
                .build()).toList();
        return ResponseEntity.ok(response);
    }

}
