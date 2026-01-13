package com.mateusnavarro77.jim_hats_web_api.infra;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mateusnavarro77.jim_hats_web_api.domain.exceptions.EmailAlreadyTakenException;
import com.mateusnavarro77.jim_hats_web_api.domain.exceptions.UsernameAlreadyTakenException;
import com.mateusnavarro77.jim_hats_web_api.domain.usecases.register_user.RegisterUserInput;
import com.mateusnavarro77.jim_hats_web_api.domain.usecases.register_user.RegisterUserUsecase;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@RestController
@RequestMapping("/auth")
public class AuthController {
    final private RegisterUserUsecase registerUserUsecase;

    public AuthController(RegisterUserUsecase registerUserUsecase) {
        this.registerUserUsecase = registerUserUsecase;
    }

    @PostMapping("/register")
    public ResponseEntity<String> register(@RequestBody RegisterUserInput registerUserInput)
            throws UsernameAlreadyTakenException, EmailAlreadyTakenException {

        return ResponseEntity.ok("User registered successfully");

    }

}
