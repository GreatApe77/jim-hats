package com.mateusnavarro77.jim_hats_web_api.shared.validation.annotations;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import jakarta.validation.ReportAsSingleViolation;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

@Documented
@Constraint(validatedBy = {})
@Target({ ElementType.FIELD, ElementType.PARAMETER })
@Retention(RetentionPolicy.RUNTIME)
@ReportAsSingleViolation
@Size(max = 40)
@Pattern(regexp = "^\\p{L}+$", message = "Last name must contain only letters and no spaces")
public @interface LastName {

    String message() default "Last name must contain only letters, no spaces, and be at most 40 characters long";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};
}
