package com.mateusnavarro77.jim_hats_web_api.shared.validation.annotations;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import jakarta.validation.ReportAsSingleViolation;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

import java.lang.annotation.*;

@Documented
@Constraint(validatedBy = {})
@Target({ ElementType.FIELD, ElementType.PARAMETER })
@Retention(RetentionPolicy.RUNTIME)
@ReportAsSingleViolation

@NotBlank
@Size(max = 40)
@Pattern(regexp = "^\\p{L}+$", message = "First name must contain only letters and no spaces")
public @interface FirstName {

    String message() default "First name must not be blank, must contain only letters, and be at most 40 characters long";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
