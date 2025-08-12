package com.mateusnavarro77.jim_hats_web_api.domain.usecases.register_user;

import com.mateusnavarro77.jim_hats_web_api.domain.exceptions.DomainException;
import com.mateusnavarro77.jim_hats_web_api.domain.exceptions.EmailAlreadyTakenException;
import com.mateusnavarro77.jim_hats_web_api.domain.exceptions.UsernameAlreadyTakenException;
import com.mateusnavarro77.jim_hats_web_api.domain.models.User;
import com.mateusnavarro77.jim_hats_web_api.domain.repositories.UsersRepository;
import com.mateusnavarro77.jim_hats_web_api.domain.services.PasswordEncrypter;
import com.mateusnavarro77.jim_hats_web_api.domain.usecases.Usecase;

public class RegisterUserUsecase implements Usecase<RegisterUserInput, RegisterUserOutput> {
    private final UsersRepository usersRepository;
    private final PasswordEncrypter passwordEncrypter;

    public RegisterUserUsecase(UsersRepository usersRepository, PasswordEncrypter passwordEncrypter) {
        this.usersRepository = usersRepository;
        this.passwordEncrypter = passwordEncrypter;
    }

    @Override
    public RegisterUserOutput execute(RegisterUserInput input)
            throws UsernameAlreadyTakenException, EmailAlreadyTakenException {
        final String username = input.username();
        final String email = input.email();
        final String plainTextPassword = input.plainTextPassword();

        final String hashedPassword = passwordEncrypter.encrypt(plainTextPassword);
        final User user = new User(username, hashedPassword, email, null);
        final User insertedUser = usersRepository.insert(user);
        return new RegisterUserOutput(insertedUser.getId(), insertedUser.getUsername());
    }
}