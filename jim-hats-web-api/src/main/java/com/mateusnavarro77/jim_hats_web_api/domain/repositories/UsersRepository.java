package com.mateusnavarro77.jim_hats_web_api.domain.repositories;

import com.mateusnavarro77.jim_hats_web_api.domain.exceptions.EmailAlreadyTakenException;
import com.mateusnavarro77.jim_hats_web_api.domain.exceptions.UsernameAlreadyTakenException;
import com.mateusnavarro77.jim_hats_web_api.domain.models.User;

public interface UsersRepository {
    User insert(User user) throws UsernameAlreadyTakenException, EmailAlreadyTakenException;

    User findById(Long id);
}
