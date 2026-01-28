package com.mateusnavarro77.jim_hats_web_api.infra.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mateusnavarro77.jim_hats_web_api.infra.dto.LoginRequestDto;
import com.mateusnavarro77.jim_hats_web_api.infra.dto.RegisterDto;
import com.mateusnavarro77.jim_hats_web_api.infra.service.UserService;

import jakarta.validation.Valid;

import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@RestController
@RequestMapping("/auth")
public class AuthenticationController {

    final UserService userService;

    public AuthenticationController(UserService userService) {
        this.userService = userService;
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
    public ResponseEntity<Void> login(@RequestBody @Valid LoginRequestDto loginRequestDto) {

        return new ResponseEntity<>(HttpStatus.OK);
    }

}
