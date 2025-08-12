package com.mateusnavarro77.jim_hats_web_api.domain.exceptions;

public class EmailAlreadyTakenException extends DomainException {
    public EmailAlreadyTakenException(String email) {
        super("Email '" + email + "' is already taken.");
    }
}
