import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/exceptions/user_not_found_exception.dart';

void main() {
  group(
    'User not found exception test',
    () {
      final String expectedMessage = 'User not found';
      late UserNotFoundException userNotFoundException;
      setUp(
        () {
          userNotFoundException = UserNotFoundException();
        },
      );
      test(
        'Should display correct message',
        () {
          expect(userNotFoundException.getMessage(), expectedMessage);
        },
      );
    },
  );
}
