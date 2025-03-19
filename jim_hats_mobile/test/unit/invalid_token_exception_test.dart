import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/exceptions/invalid_token_exception.dart';

void main() {
  group(
    'Invalid token exception test',
    () {
      final String expectedMessage = 'The Auth token is invalid';
      late InvalidTokenException invalidTokenException;
      setUp(
        () {
          invalidTokenException = InvalidTokenException();
        },
      );
      test(
        'Should display correct message',
        () {
          expect(invalidTokenException.getMessage(), expectedMessage);
        },
      );
    },
  );
}
