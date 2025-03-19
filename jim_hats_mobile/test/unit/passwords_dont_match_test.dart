import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/exceptions/passwords_dont_match_exception.dart';

void main() {
  group(
    'Passwords dont match exception test',
    () {
      final String expectedMessage = 'Passwords dont match';
      late PasswordsDontMatchException passwordsDontMatchException;
      setUp(
        () {
          passwordsDontMatchException = PasswordsDontMatchException();
        },
      );
      test(
        'Should display correct message',
        () {
          expect(passwordsDontMatchException.getMessage(), expectedMessage);
        },
      );
    },
  );
}
