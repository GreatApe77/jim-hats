package com.mateusnavarro77.jim_hats_web_api.infra.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mateusnavarro77.jim_hats_web_api.infra.dto.GetUserByIdResponseDto;
import com.mateusnavarro77.jim_hats_web_api.infra.service.UserService;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

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

}
