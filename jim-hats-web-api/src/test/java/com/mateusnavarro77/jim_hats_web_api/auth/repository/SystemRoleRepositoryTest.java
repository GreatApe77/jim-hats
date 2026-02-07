package com.mateusnavarro77.jim_hats_web_api.auth.repository;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)

public class SystemRoleRepositoryTest {
    @Autowired
    private TestRestTemplate restTemplate;


    @Test
    void shouldQueryPermissionsOfSystemRole() {
        var response = restTemplate.getForEntity("/api/system-roles/1/permissions", String.class);
        System.out.println(response.getBody());
    }
}
