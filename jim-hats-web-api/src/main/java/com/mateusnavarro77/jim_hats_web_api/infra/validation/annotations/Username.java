package com.mateusnavarro77.jim_hats_web_api.infra.validation.annotations;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

import java.lang.annotation.*;

@Documented
@Constraint(validatedBy = {})
@Target({ ElementType.FIELD, ElementType.PARAMETER })
@Retention(RetentionPolicy.RUNTIME)

@NotBlank
@Size(min = 3, max = 39)
@Pattern(
    regexp = "^[A-Za-z0-9_]+$",
    message = "Username must contain only letters, numbers, and underscores, with no spaces"
)
public @interface Username {

    String message() default "Invalid username";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
