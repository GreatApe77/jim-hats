import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/utils/form_validators.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';

@GenerateMocks([Uuid])
void main() {
  group(
    'Email validation',
    () {
      test(
        'Should be a valid email',
        () {
          String validEmail = 'validemail@gmail.com';

          expect(FormValidators.validateEmail(validEmail), null);
        },
      );
      test(
        'Should NOT be a valid email (email is null)',
        () {
          String? invalidEmailNull;
          String expectedErrorMessage = 'Email is required';
          String? returnedErrorMessage =
              FormValidators.validateEmail(invalidEmailNull);
          expect(expectedErrorMessage, returnedErrorMessage);
        },
      );
      test(
        'Should NOT be a valid email (email is empty)',
        () {
          String invalidEmptyEmail = '';
          String expectedErrorMessage = 'Email is required';
          String? returnedErrorMessage =
              FormValidators.validateEmail(invalidEmptyEmail);
          expect(expectedErrorMessage, returnedErrorMessage);
        },
      );
      test(
        'Should NOT be a valid email (No @)',
        () {
          String invalidEmptyEmail = 'emailarrobagmail.com';
          String expectedErrorMessage = 'Please enter a valid email';
          String? returnedErrorMessage =
              FormValidators.validateEmail(invalidEmptyEmail);
          expect(expectedErrorMessage, returnedErrorMessage);
        },
      );
    },
  );

  group(
    'Validate password',
    () {
      test(
        'Should be a valid password',
        () {
          String validPassword = 'validpassword123';
          String? expectedErrorMessage;
          String? returnedErrorMessage =
              FormValidators.validatePassword(validPassword);

          expect(returnedErrorMessage, expectedErrorMessage);
        },
      );
      test(
        'Should not be a valid password (password is null)',
        () {
          String? nullPassword;
          String? expectedErrorMessage = 'Password is required';
          String? returnedErrorMessage =
              FormValidators.validatePassword(nullPassword);

          expect(returnedErrorMessage, expectedErrorMessage);
        },
      );
      test(
        'Should not be a valid password (password is empty)',
        () {
          String? emptyPassword = '';
          String? expectedErrorMessage = 'Password is required';
          String? returnedErrorMessage =
              FormValidators.validatePassword(emptyPassword);

          expect(returnedErrorMessage, expectedErrorMessage);
        },
      );
      test(
        'Should not be a valid password (password is less than 6 chars)',
        () {
          String? smallPassword = 'abc1';
          String? expectedErrorMessage =
              'Password must be between 6 and 20 characters';
          String? returnedErrorMessage =
              FormValidators.validatePassword(smallPassword);

          expect(returnedErrorMessage, expectedErrorMessage);
        },
      );
      test(
        'Should not be a valid password (password is more than 20 chars)',
        () {
          String bigPassword = '0123456789abcdefghijk';
          String? expectedErrorMessage =
              'Password must be between 6 and 20 characters';
          String? returnedErrorMessage =
              FormValidators.validatePassword(bigPassword);

          expect(returnedErrorMessage, expectedErrorMessage);
        },
      );
    },
  );

  group(
    'Validate group code',
    () {
      // test(
      //   'Should be a valid group code',
      //   () {
      //     final validGroupCode = '93cfcf40-f42b-43d7-bf14-83cd53b89d8e';
      //     when(Uuid.isValidUUID(fromString: validGroupCode)).thenReturn(true);

      //     // ignore: avoid_init_to_null
      //     String? expectedErrorMessage = null;
      //     String? returnedErrorMessage =
      //         FormValidators.validateGroupCode(validGroupCode);
      //     expect(returnedErrorMessage, expectedErrorMessage);
      //   },
      // );
      test('Should NOT be a valid group code (group code is empty)', () {
        final emptyGroupCode = '';
        final expectedErrorMessage = 'Group code is required';
        final returnedErrorMessage = FormValidators.validateGroupCode(emptyGroupCode);
        expect(returnedErrorMessage, expectedErrorMessage);

      },);
    },
  );
}
