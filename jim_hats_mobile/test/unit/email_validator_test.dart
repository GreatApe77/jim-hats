import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/utils/validators/email_validator.dart';

void main() {
  group(
    'Email validator',
    () {
      String validEmail = 'validemail@gmail.com';
      // ignore: avoid_init_to_null
      String? invalidNullEmail = null;
      String invalidEmptyEmail = '';
      String invalidEmail = 'invalidnotmail.com';
      // ignore: unused_local_variable
      late EmailValidator emailValidator;
      setUp(
        () {
          emailValidator = EmailValidator();
        },
      );

      test(
        'Should be a valid email',
        () {
          // ignore: avoid_init_to_null
          String? expectedReturnValue = null;
          String? result = emailValidator.validate(validEmail);
          expect(result, expectedReturnValue);
        },
      );

      test(
        'Should not be a valid email because it is null',
        () {
          // ignore: avoid_init_to_null
          String? expectedReturnValue = 'Email is required';
          String? result = emailValidator.validate(invalidNullEmail);
          expect(result, expectedReturnValue);
        },
      );
      test(
        'Should not be a valid email because it is empty',
        () {
          // ignore: avoid_init_to_null
          String? expectedReturnValue = 'Email is required';
          String? result = emailValidator.validate(invalidEmptyEmail);
          expect(result, expectedReturnValue);
        },
      );

      test(
        'Should not be a valid email because it is not an email address',
        () {
          // ignore: avoid_init_to_null
          String? expectedReturnValue = 'Please enter a valid email';
          String? result = emailValidator.validate(invalidEmail);
          expect(result, expectedReturnValue);
        },
      );
    },
  );
}
