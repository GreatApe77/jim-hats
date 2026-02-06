package com.mateusnavarro77.jim_hats_web_api.auth.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mateusnavarro77.jim_hats_web_api.auth.service.AuthProviderService;
import com.mateusnavarro77.jim_hats_web_api.infra.dto.LoginRequestDto;
import com.mateusnavarro77.jim_hats_web_api.infra.dto.LoginResponseDto;
import com.mateusnavarro77.jim_hats_web_api.infra.dto.RegisterDto;
import com.mateusnavarro77.jim_hats_web_api.users.service.UserService;

import jakarta.validation.Valid;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
// POST   /auth/register OK
// POST   /auth/login OK
// POST   /auth/logout  nao tem        (optional if using JWT)
@RestController
@RequestMapping("/auth")
public class AuthenticationController {

    final UserService userService;
    final AuthProviderService authProviderService;

    public AuthenticationController(UserService userService, AuthProviderService authProviderService) {
        this.userService = userService;
        this.authProviderService = authProviderService;
    }

    @PostMapping("/register")
    public ResponseEntity<Void> register(@RequestBody @Valid RegisterDto registerDto) {
        userService.register(
                registerDto.username(),
                registerDto.email(),
                registerDto.password(),
                registerDto.firstName(),
                registerDto.lastName());
        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    @PostMapping("/login")
    public ResponseEntity<LoginResponseDto> login(@RequestBody @Valid LoginRequestDto loginRequestDto) {

        var token = authProviderService.login(loginRequestDto.username(), loginRequestDto.password());

        return ResponseEntity.ok(new LoginResponseDto(token));

    }

}
