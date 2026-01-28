package com.mateusnavarro77.jim_hats_web_api.infra.service;

import org.springframework.http.HttpStatus;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.mateusnavarro77.jim_hats_web_api.infra.config.JwtTokenConfig;
import com.mateusnavarro77.jim_hats_web_api.infra.repository.UserRepository;
@Service
public class AuthProviderService implements UserDetailsService {
    private UserRepository userRepository;
    private PasswordEncoder passwordEncoder;
    private JwtTokenConfig jwtTokenConfig;
    public AuthProviderService(UserRepository userRepository, PasswordEncoder passwordEncoder, JwtTokenConfig jwtTokenConfig) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
        this.jwtTokenConfig = jwtTokenConfig;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return this.userRepository.findByUsername(username);
        
    }

    public String login(String username,String password){
        var user = this.userRepository.findByUsername(username);
        if(user==null){
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST);
        }
        var encryptedPassword = user.getPassword();
        var passwordMatches = this.passwordEncoder.matches(password, encryptedPassword);
        if(!passwordMatches){
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST);
        }
        return this.jwtTokenConfig.generateToken(user);

    }

    


}
