package com.mateusnavarro77.jim_hats_web_api.infra.config;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.security.oauth2.resource.OAuth2ResourceServerProperties.Jwt;
import org.springframework.stereotype.Component;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.mateusnavarro77.jim_hats_web_api.infra.entity.User;

@Component
public class JwtTokenConfig {
    @Value("${jwt.secret}")
    private String secret;

    private final String issuer = "jim-hats-web-api";

    public String generateToken(User user) {
        var encryptionAlgorithm = getEncryptionAlgorithm();

        return JWT.create()
                .withSubject(user.getId().toString())
                .withIssuer(issuer)
                .sign(encryptionAlgorithm);

    }

    public Optional<Long> validateToken(String token) {
        try {
            var encryptionAlgorithm = getEncryptionAlgorithm();
            var decodedJwt = JWT.require(encryptionAlgorithm)
                    .withIssuer(issuer)
                    .build().verify(token);
            var userId = Long.parseLong(decodedJwt.getSubject());
            return Optional.of(userId);
        } catch (JWTVerificationException e) {
            return Optional.empty();
        }

    }

    private Algorithm getEncryptionAlgorithm() {
        return Algorithm.HMAC256(secret);
    }
}
