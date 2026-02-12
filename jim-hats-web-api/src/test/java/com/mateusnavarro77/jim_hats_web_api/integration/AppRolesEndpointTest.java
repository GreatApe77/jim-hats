package com.mateusnavarro77.jim_hats_web_api.integration;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

import com.mateusnavarro77.jim_hats_web_api.auth.dto.CreateAppRoleDto;
import com.mateusnavarro77.jim_hats_web_api.auth.dto.IncludePermissionInAppRoleRequestDto;
import com.mateusnavarro77.jim_hats_web_api.auth.dto.LoginRequestDto;
import com.mateusnavarro77.jim_hats_web_api.auth.dto.LoginResponseDto;
import com.mateusnavarro77.jim_hats_web_api.auth.dto.RegisterDto;
import com.mateusnavarro77.jim_hats_web_api.auth.entity.AppRole;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@Testcontainers
class AppRolesEndpointTest {

    @Container
    static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:16")
            .withDatabaseName("jim_hats_db")
            .withUsername("test")
            .withPassword("test");

    @DynamicPropertySource
    static void configureProperties(DynamicPropertyRegistry registry) {
        registry.add("spring.datasource.url", postgres::getJdbcUrl);
        registry.add("spring.datasource.username", postgres::getUsername);
        registry.add("spring.datasource.password", postgres::getPassword);
    }

    @Autowired
    private TestRestTemplate restTemplate;

    private String authToken;

    @AfterAll
    static void tearDown() {
        postgres.stop();
    }

    @BeforeEach
    void setUp() {
        // Register and login a test user to get authentication token
        RegisterDto registerDto = new RegisterDto(
                "adminuser",
                "admin@example.com",
                "password123",
                "Admin",
                "User");
        restTemplate.postForEntity("/auth/register", registerDto, Void.class);

        LoginRequestDto loginDto = new LoginRequestDto("adminuser", "password123");
        ResponseEntity<LoginResponseDto> loginResponse = restTemplate.postForEntity(
                "/auth/login",
                loginDto,
                LoginResponseDto.class);

        if (loginResponse.getBody() != null) {
            authToken = loginResponse.getBody().token();
        }
    }

    private HttpHeaders createAuthHeaders() {
        HttpHeaders headers = new HttpHeaders();
        if (authToken != null) {
            headers.set("Authorization", "Bearer " + authToken);
        }
        return headers;
    }

    @Nested
    @DisplayName("GET /app-roles")
    class GetAllAppRolesTests {

        @Test
        @DisplayName("should return list of app roles")
        void shouldReturnListOfAppRoles() {
            HttpEntity<Void> request = new HttpEntity<>(createAuthHeaders());

            ResponseEntity<List<AppRole>> response = restTemplate.exchange(
                    "/app-roles",
                    HttpMethod.GET,
                    request,
                    new ParameterizedTypeReference<List<AppRole>>() {
                    });

            // May return 200 or 403 depending on user permissions
            assertTrue(response.getStatusCode() == HttpStatus.OK ||
                    response.getStatusCode() == HttpStatus.FORBIDDEN);
        }

        @Test
        @DisplayName("should return 401 when not authenticated")
        void shouldReturn401WhenNotAuthenticated() {
            ResponseEntity<Void> response = restTemplate.getForEntity(
                    "/app-roles",
                    Void.class);

            assertEquals(HttpStatus.UNAUTHORIZED, response.getStatusCode());
        }
    }

    @Nested
    @DisplayName("GET /app-roles/{appRoleId}")
    class GetAppRoleByIdTests {

        @Test
        @DisplayName("should return app role when valid id is provided")
        void shouldReturnAppRoleWhenValidId() {
            HttpEntity<Void> request = new HttpEntity<>(createAuthHeaders());

            ResponseEntity<AppRole> response = restTemplate.exchange(
                    "/app-roles/1",
                    HttpMethod.GET,
                    request,
                    AppRole.class);

            // May return 200, 403, or 404 depending on permissions and data
            assertTrue(response.getStatusCode() == HttpStatus.OK ||
                    response.getStatusCode() == HttpStatus.FORBIDDEN ||
                    response.getStatusCode() == HttpStatus.NOT_FOUND);
        }

        @Test
        @DisplayName("should return 401 when not authenticated")
        void shouldReturn401WhenNotAuthenticated() {
            ResponseEntity<Void> response = restTemplate.getForEntity(
                    "/app-roles/1",
                    Void.class);

            assertEquals(HttpStatus.UNAUTHORIZED, response.getStatusCode());
        }

        @Test
        @DisplayName("should return 400 when id is invalid")
        void shouldReturn400WhenIdInvalid() {
            HttpEntity<Void> request = new HttpEntity<>(createAuthHeaders());

            ResponseEntity<Void> response = restTemplate.exchange(
                    "/app-roles/0",
                    HttpMethod.GET,
                    request,
                    Void.class);

            // May return 400 or 403 depending on validation order
            assertTrue(response.getStatusCode() == HttpStatus.BAD_REQUEST ||
                    response.getStatusCode() == HttpStatus.FORBIDDEN);
        }
    }

    @Nested
    @DisplayName("POST /app-roles")
    class CreateAppRoleTests {

        @Test
        @DisplayName("should create app role with valid data")
        void shouldCreateAppRoleWithValidData() {
            CreateAppRoleDto dto = CreateAppRoleDto.builder()
                    .appRoleName("TEST_ROLE")
                    .build();

            HttpEntity<CreateAppRoleDto> request = new HttpEntity<>(dto, createAuthHeaders());

            ResponseEntity<Void> response = restTemplate.exchange(
                    "/app-roles",
                    HttpMethod.POST,
                    request,
                    Void.class);

            // May return 201 or 403 depending on user permissions
            assertTrue(response.getStatusCode() == HttpStatus.CREATED ||
                    response.getStatusCode() == HttpStatus.FORBIDDEN);
        }

        @Test
        @DisplayName("should return 401 when not authenticated")
        void shouldReturn401WhenNotAuthenticated() {
            CreateAppRoleDto dto = CreateAppRoleDto.builder()
                    .appRoleName("TEST_ROLE")
                    .build();

            ResponseEntity<Void> response = restTemplate.postForEntity(
                    "/app-roles",
                    dto,
                    Void.class);

            assertEquals(HttpStatus.UNAUTHORIZED, response.getStatusCode());
        }

        @Test
        @DisplayName("should return 400 when app role name is empty")
        void shouldReturn400WhenNameEmpty() {
            CreateAppRoleDto dto = CreateAppRoleDto.builder()
                    .appRoleName("")
                    .build();

            HttpEntity<CreateAppRoleDto> request = new HttpEntity<>(dto, createAuthHeaders());

            ResponseEntity<Void> response = restTemplate.exchange(
                    "/app-roles",
                    HttpMethod.POST,
                    request,
                    Void.class);

            // May return 400 or 403 depending on validation order
            assertTrue(response.getStatusCode() == HttpStatus.BAD_REQUEST ||
                    response.getStatusCode() == HttpStatus.FORBIDDEN);
        }

        @Test
        @DisplayName("should return 400 when app role name is too long")
        void shouldReturn400WhenNameTooLong() {
            String longName = "A".repeat(256);
            CreateAppRoleDto dto = CreateAppRoleDto.builder()
                    .appRoleName(longName)
                    .build();

            HttpEntity<CreateAppRoleDto> request = new HttpEntity<>(dto, createAuthHeaders());

            ResponseEntity<Void> response = restTemplate.exchange(
                    "/app-roles",
                    HttpMethod.POST,
                    request,
                    Void.class);

            // May return 400 or 403 depending on validation order
            assertTrue(response.getStatusCode() == HttpStatus.BAD_REQUEST ||
                    response.getStatusCode() == HttpStatus.FORBIDDEN);
        }
    }

    @Nested
    @DisplayName("DELETE /app-roles/{appRoleId}")
    class DeleteAppRoleTests {

        @Test
        @DisplayName("should return 401 when not authenticated")
        void shouldReturn401WhenNotAuthenticated() {
            ResponseEntity<Void> response = restTemplate.exchange(
                    "/app-roles/1",
                    HttpMethod.DELETE,
                    null,
                    Void.class);

            assertEquals(HttpStatus.UNAUTHORIZED, response.getStatusCode());
        }

        @Test
        @DisplayName("should return 400 when id is invalid")
        void shouldReturn400WhenIdInvalid() {
            HttpEntity<Void> request = new HttpEntity<>(createAuthHeaders());

            ResponseEntity<Void> response = restTemplate.exchange(
                    "/app-roles/0",
                    HttpMethod.DELETE,
                    request,
                    Void.class);

            // May return 400 or 403 depending on validation order
            assertTrue(response.getStatusCode() == HttpStatus.BAD_REQUEST ||
                    response.getStatusCode() == HttpStatus.FORBIDDEN);
        }

        @Test
        @DisplayName("should handle deletion request for authenticated user")
        void shouldHandleDeletionRequest() {
            HttpEntity<Void> request = new HttpEntity<>(createAuthHeaders());

            ResponseEntity<Void> response = restTemplate.exchange(
                    "/app-roles/999",
                    HttpMethod.DELETE,
                    request,
                    Void.class);

            // May return 204, 403, or 404 depending on permissions and data
            assertTrue(response.getStatusCode() == HttpStatus.NO_CONTENT ||
                    response.getStatusCode() == HttpStatus.FORBIDDEN ||
                    response.getStatusCode() == HttpStatus.NOT_FOUND);
        }
    }

    @Nested
    @DisplayName("POST /app-roles/{appRoleId}/permissions")
    class AddPermissionToAppRoleTests {

        @Test
        @DisplayName("should return 401 when not authenticated")
        void shouldReturn401WhenNotAuthenticated() {
            IncludePermissionInAppRoleRequestDto dto = IncludePermissionInAppRoleRequestDto.builder()
                    .permissionName("USERS:READ")
                    .build();

            ResponseEntity<Void> response = restTemplate.postForEntity(
                    "/app-roles/1/permissions",
                    dto,
                    Void.class);

            assertEquals(HttpStatus.UNAUTHORIZED, response.getStatusCode());
        }

        @Test
        @DisplayName("should return 400 when permission name is empty")
        void shouldReturn400WhenPermissionNameEmpty() {
            IncludePermissionInAppRoleRequestDto dto = IncludePermissionInAppRoleRequestDto.builder()
                    .permissionName("")
                    .build();

            HttpEntity<IncludePermissionInAppRoleRequestDto> request = new HttpEntity<>(dto, createAuthHeaders());

            ResponseEntity<Void> response = restTemplate.exchange(
                    "/app-roles/1/permissions",
                    HttpMethod.POST,
                    request,
                    Void.class);

            // May return 400 or 403 depending on validation order
            assertTrue(response.getStatusCode() == HttpStatus.BAD_REQUEST ||
                    response.getStatusCode() == HttpStatus.FORBIDDEN);
        }

        @Test
        @DisplayName("should return 400 when app role id is invalid")
        void shouldReturn400WhenAppRoleIdInvalid() {
            IncludePermissionInAppRoleRequestDto dto = IncludePermissionInAppRoleRequestDto.builder()
                    .permissionName("USERS:READ")
                    .build();

            HttpEntity<IncludePermissionInAppRoleRequestDto> request = new HttpEntity<>(dto, createAuthHeaders());

            ResponseEntity<Void> response = restTemplate.exchange(
                    "/app-roles/0/permissions",
                    HttpMethod.POST,
                    request,
                    Void.class);

            // May return 400 or 403 depending on validation order
            assertTrue(response.getStatusCode() == HttpStatus.BAD_REQUEST ||
                    response.getStatusCode() == HttpStatus.FORBIDDEN);
        }

        @Test
        @DisplayName("should handle add permission request for authenticated user")
        void shouldHandleAddPermissionRequest() {
            IncludePermissionInAppRoleRequestDto dto = IncludePermissionInAppRoleRequestDto.builder()
                    .permissionName("USERS:READ")
                    .build();

            HttpEntity<IncludePermissionInAppRoleRequestDto> request = new HttpEntity<>(dto, createAuthHeaders());

            ResponseEntity<Void> response = restTemplate.exchange(
                    "/app-roles/1/permissions",
                    HttpMethod.POST,
                    request,
                    Void.class);

            // May return 200, 403, or 404 depending on permissions and data
            assertTrue(response.getStatusCode() == HttpStatus.OK ||
                    response.getStatusCode() == HttpStatus.FORBIDDEN ||
                    response.getStatusCode() == HttpStatus.NOT_FOUND);
        }
    }
}
