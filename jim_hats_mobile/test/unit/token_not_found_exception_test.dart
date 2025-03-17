import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/exceptions/token_not_found_exception.dart';

void main() {
  group(
    'Token not found exception test',
    () {
      final String expectedMessage = 'Token not found';
      late TokenNotFoundException tokenNotFoundException;
      setUp(
        () {
          tokenNotFoundException = TokenNotFoundException();
        },
      );
      test(
        'Should display correct message',
        () {
          expect(tokenNotFoundException.getMessage(), expectedMessage);
        },
      );
    },
  );
}
