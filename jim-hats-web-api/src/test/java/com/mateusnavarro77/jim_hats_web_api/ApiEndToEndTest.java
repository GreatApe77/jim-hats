package com.mateusnavarro77.jim_hats_web_api;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.testcontainers.containers.PostgreSQLContainer;

import net.bytebuddy.utility.dispatcher.JavaDispatcher.Container;

import static org.junit.jupiter.api.Assertions.*;


@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class ApiEndToEndTest {

    @Autowired
    private TestRestTemplate restTemplate;
    
    static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:16");

    @Test
    void shouldReachHealthEndpoint() {
        ResponseEntity<String> response = restTemplate.getForEntity("/health", String.class);
        assertEquals(HttpStatus.OK, response.getStatusCode());

    }
}
