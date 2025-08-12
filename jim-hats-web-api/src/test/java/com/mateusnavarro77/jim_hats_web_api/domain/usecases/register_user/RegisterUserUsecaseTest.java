package com.mateusnavarro77.jim_hats_web_api.domain.usecases.register_user;

import com.mateusnavarro77.jim_hats_web_api.domain.exceptions.EmailAlreadyTakenException;
import com.mateusnavarro77.jim_hats_web_api.domain.exceptions.UsernameAlreadyTakenException;
import com.mateusnavarro77.jim_hats_web_api.domain.models.User;
import com.mateusnavarro77.jim_hats_web_api.domain.repositories.UsersRepository;
import com.mateusnavarro77.jim_hats_web_api.domain.services.PasswordEncrypter;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.time.LocalDateTime;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;

public class RegisterUserUsecaseTest {

    @Mock
    private UsersRepository usersRepository;

    @Mock
    private PasswordEncrypter passwordEncrypter;

    @InjectMocks
    private RegisterUserUsecase registerUserUsecase;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void execute_shouldReturnRegisterUserOutput_whenUserIsRegisteredSuccessfully() throws UsernameAlreadyTakenException, EmailAlreadyTakenException {
        // Arrange
        RegisterUserInput input = new RegisterUserInput("testuser", "test@example.com", "password123");
        String hashedPassword = "hashedPassword";
        User insertedUser = new User(1L, input.username(), hashedPassword, input.email(), null, LocalDateTime.now(), LocalDateTime.now());

        when(passwordEncrypter.encrypt(input.plainTextPassword())).thenReturn(hashedPassword);
        when(usersRepository.insert(any(User.class))).thenReturn(insertedUser);

        // Act
        RegisterUserOutput output = registerUserUsecase.execute(input);

        // Assert
        assertNotNull(output);
        assertEquals(insertedUser.getId(), output.userId());
        assertEquals(insertedUser.getUsername(), output.username());
    }

    @Test
    void execute_shouldThrowUsernameAlreadyTakenException_whenUsernameIsAlreadyTaken() throws UsernameAlreadyTakenException, EmailAlreadyTakenException {
        // Arrange
        RegisterUserInput input = new RegisterUserInput("testuser", "test@example.com", "password123");
        String hashedPassword = "hashedPassword";

        when(passwordEncrypter.encrypt(input.plainTextPassword())).thenReturn(hashedPassword);
        when(usersRepository.insert(any(User.class))).thenThrow(new UsernameAlreadyTakenException("Username already taken"));

        // Act & Assert
        assertThrows(UsernameAlreadyTakenException.class, () -> {
            registerUserUsecase.execute(input);
        });
    }

    @Test
    void execute_shouldThrowEmailAlreadyTakenException_whenEmailIsAlreadyTaken() throws UsernameAlreadyTakenException, EmailAlreadyTakenException {
        // Arrange
        RegisterUserInput input = new RegisterUserInput("testuser", "test@example.com", "password123");
        String hashedPassword = "hashedPassword";

        when(passwordEncrypter.encrypt(input.plainTextPassword())).thenReturn(hashedPassword);
        when(usersRepository.insert(any(User.class))).thenThrow(new EmailAlreadyTakenException("Email already taken"));

        // Act & Assert
        assertThrows(EmailAlreadyTakenException.class, () -> {
            registerUserUsecase.execute(input);
        });
    }
}
