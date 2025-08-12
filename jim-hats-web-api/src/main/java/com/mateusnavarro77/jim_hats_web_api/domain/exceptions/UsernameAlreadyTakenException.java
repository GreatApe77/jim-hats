package com.mateusnavarro77.jim_hats_web_api.domain.exceptions;

public class UsernameAlreadyTakenException extends DomainException {
    public UsernameAlreadyTakenException(String username) {
        super("Username '" + username + "' is already taken.");
    }
}
