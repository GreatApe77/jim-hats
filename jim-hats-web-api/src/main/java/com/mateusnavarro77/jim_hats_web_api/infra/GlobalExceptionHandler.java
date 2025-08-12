package com.mateusnavarro77.jim_hats_web_api.infra;

import com.mateusnavarro77.jim_hats_web_api.domain.exceptions.EmailAlreadyTakenException;
import com.mateusnavarro77.jim_hats_web_api.domain.exceptions.UsernameAlreadyTakenException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import java.util.Map;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(UsernameAlreadyTakenException.class)
    public ResponseEntity<Map<String, String>> handleUsernameAlreadyTaken(UsernameAlreadyTakenException ex) {
        return ResponseEntity
                .status(HttpStatus.FORBIDDEN) // 409
                .body(Map.of("error", ex.getMessage()));
    }

    @ExceptionHandler(EmailAlreadyTakenException.class)
    public ResponseEntity<Map<String, String>> handleEmailAlreadyTaken(EmailAlreadyTakenException ex) {
        return ResponseEntity
                .status(HttpStatus.FORBIDDEN) // 409
                .body(Map.of("error", ex.getMessage()));
    }
}
