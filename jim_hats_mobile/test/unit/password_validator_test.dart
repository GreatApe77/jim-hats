import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/utils/validators/password_validator.dart';

void main() {
  group(
    'Password validation tests',
    () {
      final invalidNullPassword = null;
      final invalidEmptyPassword = '';
      final invalidShortPassword = 'less6';
      final invalidLongPassword = 'this_is_a_long_password';
      final validPassword = 'valid_password123';

      late PasswordValidator passwordValidator;

      setUp(
        () {
          passwordValidator = PasswordValidator();
        },
      );

      test(
        'Should return null if password is valid',
        () {
          final expectedErrorMessage = null;
          final result = passwordValidator.validate(validPassword);
          expect(result, expectedErrorMessage);
        },
      );
      test(
        'Should not be a valid password because it is null',
        () {
          final expectedErrorMessage = 'Password is required';
          final result = passwordValidator.validate(invalidNullPassword);
          expect(result, expectedErrorMessage);
        },
      );
      test(
        'Should not be a valid password because it is empty',
        () {
          final expectedErrorMessage = 'Password is required';
          final result = passwordValidator.validate(invalidEmptyPassword);
          expect(result, expectedErrorMessage);
        },
      );
      test(
        'Should not be a valid password because it is shorter than 6 chars',
        () {
          final expectedErrorMessage =
              'Password must be between 6 and 20 characters';
          final result = passwordValidator.validate(invalidShortPassword);
          expect(result, expectedErrorMessage);
        },
      );
      test(
        'Should not be a valid password because it is greater than 20 chars',
        () {
          final expectedErrorMessage =
              'Password must be between 6 and 20 characters';
          final result = passwordValidator.validate(invalidLongPassword);
          expect(result, expectedErrorMessage);
        },
      );
    },
  );
}
