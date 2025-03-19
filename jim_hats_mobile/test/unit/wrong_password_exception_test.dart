import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/exceptions/wrong_password_exception.dart';

void main() {
  group(
    'Wrong password exception test',
    () {
      final String expectedMessage = 'Wrong password';
      late WrongPasswordException wrongPasswordException;
      setUp(
        () {
          wrongPasswordException = WrongPasswordException();
        },
      );
      test(
        'Should display correct message',
        () {
          expect(wrongPasswordException.getMessage(), expectedMessage);
        },
      );
    },
  );
}
