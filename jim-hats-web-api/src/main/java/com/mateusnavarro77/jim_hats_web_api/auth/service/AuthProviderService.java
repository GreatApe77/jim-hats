package com.mateusnavarro77.jim_hats_web_api.auth.service;

import org.springframework.http.HttpStatus;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.mateusnavarro77.jim_hats_web_api.users.repository.UserRepository;
@Service
public class AuthProviderService implements UserDetailsService {
    private UserRepository userRepository;
    private PasswordEncoder passwordEncoder;
    private JwtService jwtService;
    public AuthProviderService(UserRepository userRepository, PasswordEncoder passwordEncoder, JwtService jwtService) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
        this.jwtService = jwtService;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return this.userRepository.findByUsername(username);
        
    }

    public String login(String username,String password){
        var user = this.userRepository.findByUsername(username);
        if(user==null){
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED);
        }
        var encryptedPassword = user.getPassword();
        var passwordMatches = this.passwordEncoder.matches(password, encryptedPassword);
        if(!passwordMatches){
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED);
        }
        return this.jwtService.generateToken(user);

    }

    


}
