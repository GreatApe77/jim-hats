package com.mateusnavarro77.jim_hats_web_api.infra.validation.annotations;

import java.lang.annotation.*;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import jakarta.validation.ReportAsSingleViolation;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

@Documented
@Constraint(validatedBy = {})
@Target({ ElementType.FIELD, ElementType.PARAMETER })
@Retention(RetentionPolicy.RUNTIME)
@ReportAsSingleViolation
@NotBlank
@Size(min = 8, max = 32)
@Pattern(regexp = "^\\S+$", message = "Password must not contain spaces")
public @interface PlainTextPassword {
    String message() default "Password must be 8–32 characters long and must not contain spaces";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
