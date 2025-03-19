import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/utils/validators/username_validator.dart';

void main() {
  group(
    'Username validator',
    () {
      String invalidEmptyUsername = '';
      String? invalidNullUsername = null;
      String invalidShortUsername = 'ab';
      String invalidLongUsername = 'this_is_a_long_username';
      String invalidUsernameWithSpaces = 'peter _ parker';
      String validUsername = 'peter_parker77';
      late UsernameValidator usernameValidator;

      setUp(
        () {
          usernameValidator = UsernameValidator();
        },
      );

      test(
        'Should be a valid username',
        () {
          // ignore: avoid_init_to_null
          String? expectedErrorMessage = null;
          String? result = usernameValidator.validate(validUsername);
          expect(result, expectedErrorMessage);
        },
      );
      test(
        'Should not be a valid username because it is null',
        () {
          // ignore: avoid_init_to_null
          String? expectedErrorMessage = 'Username is required';
          String? result = usernameValidator.validate(invalidNullUsername);
          expect(result, expectedErrorMessage);
        },
      );
      test(
        'Should not be a valid username because it is empty',
        () {
          // ignore: avoid_init_to_null
          String? expectedErrorMessage = 'Username is required';
          String? result = usernameValidator.validate(invalidEmptyUsername);
          expect(result, expectedErrorMessage);
        },
      );
      test(
        'Should not be a valid username because it contain spaces',
        () {
          // ignore: avoid_init_to_null
          String? expectedErrorMessage = 'Username cannot contain spaces';
          String? result =
              usernameValidator.validate(invalidUsernameWithSpaces);
          expect(result, expectedErrorMessage);
        },
      );
      test(
        'Should not be a valid username because it is smaller than 3 chars',
        () {
          // ignore: avoid_init_to_null
          String? expectedErrorMessage =
              'Username must be between 3 and 20 characters';
          String? result = usernameValidator.validate(invalidShortUsername);
          expect(result, expectedErrorMessage);
        },
      );
      test(
        'Should not be a valid username because it is longer than 20 chars',
        () {
          // ignore: avoid_init_to_null
          String? expectedErrorMessage =
              'Username must be between 3 and 20 characters';
          String? result = usernameValidator.validate(invalidLongUsername);
          expect(result, expectedErrorMessage);
        },
      );
    },
  );
}
