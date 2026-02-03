package com.mateusnavarro77.jim_hats_web_api.infra.controller;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;


@RestController
public class HealthController {
    

    @GetMapping("/health")
    public ResponseEntity<String> checkApiHealth() {
        return ResponseEntity.ok("API is healthy");
    }
    

}
