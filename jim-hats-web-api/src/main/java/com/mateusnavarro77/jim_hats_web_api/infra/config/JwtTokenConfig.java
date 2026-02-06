package com.mateusnavarro77.jim_hats_web_api.infra.config;

import java.time.Instant;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.mateusnavarro77.jim_hats_web_api.users.entity.User;

@Component
public class JwtTokenConfig {
    @Value("${jwt.secret}")
    private String secret;

    private final String issuer = "jim-hats-web-api";
    private final Long durationInSeconds = 600L; // 10 minutes

    public String generateToken(User user) {
        var encryptionAlgorithm = getEncryptionAlgorithm();
        var now = Instant.now();

        return JWT.create()
                .withClaim("systemRole", user.getSystemRole().getName())
                .withSubject(user.getId().toString())
                .withIssuer(issuer)
                .withIssuedAt(now)
                .withExpiresAt(now.plusSeconds(durationInSeconds))
                .sign(encryptionAlgorithm);

    }

    public Optional<JwtUserData> validateToken(String token) {
        try {
            var encryptionAlgorithm = getEncryptionAlgorithm();
            var decodedJwt = JWT.require(encryptionAlgorithm)
                    .withIssuer(issuer)
                    .build().verify(token);
            var jwtUserData = JwtUserData.builder()
                    .id(Long.parseLong(decodedJwt.getSubject()))
                    .systemRole(decodedJwt.getClaim("systemRole").asString())
                    .build();
            
            return Optional.of(jwtUserData);
        } catch (JWTVerificationException e) {
            return Optional.empty();
        }

    }

    private Algorithm getEncryptionAlgorithm() {
        return Algorithm.HMAC256(secret);
    }
}
