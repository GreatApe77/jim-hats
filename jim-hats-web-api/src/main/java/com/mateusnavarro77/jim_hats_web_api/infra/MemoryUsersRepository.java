package com.mateusnavarro77.jim_hats_web_api.infra;

import java.util.ArrayList;

import com.mateusnavarro77.jim_hats_web_api.domain.exceptions.EmailAlreadyTakenException;
import com.mateusnavarro77.jim_hats_web_api.domain.exceptions.UsernameAlreadyTakenException;
import com.mateusnavarro77.jim_hats_web_api.domain.models.User;
import com.mateusnavarro77.jim_hats_web_api.domain.repositories.UsersRepository;

public class MemoryUsersRepository implements UsersRepository {
    final ArrayList<User> users = new ArrayList<User>();

    /*
     * @Override
     * public User save(User user) {
     * user.setId(users.size() + 1);
     * users.add(user);
     * return user;
     * }
     * 
     * @Override
     * public List<User> findAll() {
     * return users;
     * }
     */

    @Override
    public User insert(User user) throws UsernameAlreadyTakenException, EmailAlreadyTakenException {
        for (User existingUser : users) {
            if (existingUser.getUsername().equals(user.getUsername())) {
                throw new UsernameAlreadyTakenException(user.getUsername());
            }
            if (existingUser.getEmail().equals(user.getEmail())) {
                throw new EmailAlreadyTakenException(user.getEmail());
            }
        }
        user.setId((long) (users.size() + 1));
        users.add(user);
        return user;
    }

    @Override
    public User findById(Long id) {
        return users.stream()
                .filter(user -> user.getId().equals(id))
                .findFirst()
                .orElse(null);
    }
}
