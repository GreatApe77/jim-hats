package com.mateusnavarro77.jim_hats_web_api.infra;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.mateusnavarro77.jim_hats_web_api.domain.usecases.register_user.RegisterUserUsecase;

@Configuration
public class BeanConfig {

    @Bean
    public RegisterUserUsecase registerUserUsecase() {
        return new RegisterUserUsecase(new MemoryUsersRepository(), new BCryptPasswordEncrypter());
    }

}
