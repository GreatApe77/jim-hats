import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/exceptions/username_already_taken_exception.dart';

void main() {
  group(
    'Username already taken exception test',
    () {
      final String expectedMessage = 'Username already taken';
      late UsernameAlreadyTakenException usernameAlreadyTakenException;
      setUp(
        () {
          usernameAlreadyTakenException = UsernameAlreadyTakenException();
        },
      );
      test(
        'Should display correct message',
        () {
          expect(usernameAlreadyTakenException.getMessage(), expectedMessage);
        },
      );
    },
  );
}
