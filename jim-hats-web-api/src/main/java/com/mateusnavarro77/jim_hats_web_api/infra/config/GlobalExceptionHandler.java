package com.mateusnavarro77.jim_hats_web_api.infra.config;

import java.time.Instant;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.server.ResponseStatusException;

@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(ResponseStatusException.class)
    public ResponseEntity<ErrorResponseDto> handleResponseStatusException(ResponseStatusException ex) {
        return ResponseEntity
                .status(ex.getStatusCode())
                .body(ErrorResponseDto.builder()
                        .reason(ex.getReason())
                        .status(ex.getStatusCode().value())
                        .timestamp((int) Instant.now().toEpochMilli())
                        .build());
    }
}