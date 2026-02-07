package com.mateusnavarro77.jim_hats_web_api;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class ApiEndToEndTest {

    @Autowired
    private TestRestTemplate restTemplate;

    @Test
    void shouldReachHealthEndpoint() {
        ResponseEntity<String> response = restTemplate.getForEntity("/health", String.class);
        assertEquals(HttpStatus.OK, response.getStatusCode());
        
       
    }
}
