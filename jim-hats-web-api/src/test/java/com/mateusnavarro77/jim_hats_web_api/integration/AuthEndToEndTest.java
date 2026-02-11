package com.mateusnavarro77.jim_hats_web_api.integration;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

import com.mateusnavarro77.jim_hats_web_api.auth.dto.LoginRequestDto;
import com.mateusnavarro77.jim_hats_web_api.auth.dto.LoginResponseDto;
import com.mateusnavarro77.jim_hats_web_api.auth.dto.RegisterDto;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@Testcontainers
class AuthEndToEndTest {

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

    @Nested
    @DisplayName("POST /auth/register")
    class RegisterTests {

        @Test
        @DisplayName("should register a new user successfully")
        void shouldRegisterNewUser() {
            RegisterDto registerDto = new RegisterDto(
                    "testuser123",
                    "testuser@example.com",
                    "password123",
                    "John",
                    "Doe");

            ResponseEntity<Void> response = restTemplate.postForEntity(
                    "/auth/register",
                    registerDto,
                    Void.class);

            assertEquals(HttpStatus.CREATED, response.getStatusCode());
        }

        @Test
        @DisplayName("should return 400 when username is too short")
        void shouldReturn400WhenUsernameTooShort() {
            RegisterDto registerDto = new RegisterDto(
                    "ab", // Less than 3 characters
                    "test@example.com",
                    "password123",
                    "John",
                    "Doe");

            ResponseEntity<Void> response = restTemplate.postForEntity(
                    "/auth/register",
                    registerDto,
                    Void.class);

            assertEquals(HttpStatus.BAD_REQUEST, response.getStatusCode());
        }

        @Test
        @DisplayName("should return 400 when password is too short")
        void shouldReturn400WhenPasswordTooShort() {
            RegisterDto registerDto = new RegisterDto(
                    "validuser",
                    "test@example.com",
                    "short", // Less than 8 characters
                    "John",
                    "Doe");

            ResponseEntity<Void> response = restTemplate.postForEntity(
                    "/auth/register",
                    registerDto,
                    Void.class);

            assertEquals(HttpStatus.BAD_REQUEST, response.getStatusCode());
        }

        @Test
        @DisplayName("should return 400 when email is invalid")
        void shouldReturn400WhenEmailInvalid() {
            RegisterDto registerDto = new RegisterDto(
                    "validuser2",
                    "not-an-email",
                    "password123",
                    "John",
                    "Doe");

            ResponseEntity<Void> response = restTemplate.postForEntity(
                    "/auth/register",
                    registerDto,
                    Void.class);

            assertEquals(HttpStatus.BAD_REQUEST, response.getStatusCode());
        }

        @Test
        @DisplayName("should return 400 when registering duplicate username")
        void shouldReturn400WhenDuplicateUsername() {
            RegisterDto registerDto = new RegisterDto(
                    "duplicateuser",
                    "first@example.com",
                    "password123",
                    "John",
                    "Doe");

            // Register first time
            restTemplate.postForEntity("/auth/register", registerDto, Void.class);

            // Try to register again with same username
            RegisterDto duplicateDto = new RegisterDto(
                    "duplicateuser",
                    "second@example.com",
                    "password456",
                    "Jane",
                    "Smith");

            ResponseEntity<Void> response = restTemplate.postForEntity(
                    "/auth/register",
                    duplicateDto,
                    Void.class);

            assertEquals(HttpStatus.BAD_REQUEST, response.getStatusCode());
        }
    }

    @Nested
    @DisplayName("POST /auth/login")
    class LoginTests {

        @BeforeEach
        void setUp() {
            // Register a test user for login tests
            RegisterDto registerDto = new RegisterDto(
                    "loginuser",
                    "loginuser@example.com",
                    "password123",
                    "Login",
                    "User");
            restTemplate.postForEntity("/auth/register", registerDto, Void.class);
        }

        @Test
        @DisplayName("should login successfully with valid credentials")
        void shouldLoginSuccessfully() {
            LoginRequestDto loginDto = new LoginRequestDto("loginuser", "password123");

            ResponseEntity<LoginResponseDto> response = restTemplate.postForEntity(
                    "/auth/login",
                    loginDto,
                    LoginResponseDto.class);

            assertEquals(HttpStatus.OK, response.getStatusCode());
            assertNotNull(response.getBody());
            assertNotNull(response.getBody().token());
            assertFalse(response.getBody().token().isEmpty());
        }

        @Test
        @DisplayName("should return 401 with invalid password")
        void shouldReturn401WithInvalidPassword() {
            LoginRequestDto loginDto = new LoginRequestDto("loginuser", "wrongpassword");

            ResponseEntity<Void> response = restTemplate.postForEntity(
                    "/auth/login",
                    loginDto,
                    Void.class);

            assertEquals(HttpStatus.UNAUTHORIZED, response.getStatusCode());
        }

        @Test
        @DisplayName("should return 401 with non-existent username")
        void shouldReturn401WithNonExistentUser() {
            LoginRequestDto loginDto = new LoginRequestDto("nonexistent", "password123");

            ResponseEntity<Void> response = restTemplate.postForEntity(
                    "/auth/login",
                    loginDto,
                    Void.class);

            assertEquals(HttpStatus.UNAUTHORIZED, response.getStatusCode());
        }

        @Test
        @DisplayName("should return 400 when username is blank")
        void shouldReturn400WhenUsernameBlank() {
            LoginRequestDto loginDto = new LoginRequestDto("", "password123");

            ResponseEntity<Void> response = restTemplate.postForEntity(
                    "/auth/login",
                    loginDto,
                    Void.class);

            assertEquals(HttpStatus.BAD_REQUEST, response.getStatusCode());
        }

        @Test
        @DisplayName("should return 400 when password is blank")
        void shouldReturn400WhenPasswordBlank() {
            LoginRequestDto loginDto = new LoginRequestDto("loginuser", "");

            ResponseEntity<Void> response = restTemplate.postForEntity(
                    "/auth/login",
                    loginDto,
                    Void.class);

            assertEquals(HttpStatus.BAD_REQUEST, response.getStatusCode());
        }
    }

    @Nested
    @DisplayName("Auth Flow Integration")
    class AuthFlowTests {

        @Test
        @DisplayName("should register and then login successfully")
        void shouldRegisterAndLogin() {
            // Register
            RegisterDto registerDto = new RegisterDto(
                    "flowuser",
                    "flowuser@example.com",
                    "password123",
                    "Flow",
                    "User");

            ResponseEntity<Void> registerResponse = restTemplate.postForEntity(
                    "/auth/register",
                    registerDto,
                    Void.class);
            assertEquals(HttpStatus.CREATED, registerResponse.getStatusCode());

            // Login
            LoginRequestDto loginDto = new LoginRequestDto("flowuser", "password123");

            ResponseEntity<LoginResponseDto> loginResponse = restTemplate.postForEntity(
                    "/auth/login",
                    loginDto,
                    LoginResponseDto.class);

            assertEquals(HttpStatus.OK, loginResponse.getStatusCode());
            assertNotNull(loginResponse.getBody());
            assertNotNull(loginResponse.getBody().token());
        }
    }
}
