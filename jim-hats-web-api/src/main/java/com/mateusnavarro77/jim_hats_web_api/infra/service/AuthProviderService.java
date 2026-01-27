package com.mateusnavarro77.jim_hats_web_api.infra.service;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.mateusnavarro77.jim_hats_web_api.infra.repository.UserRepository;
@Service
public class AuthProviderService implements UserDetailsService {
    private UserRepository userRepository;

    public AuthProviderService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return this.userRepository.findByUsername(username);
        
    }


}
