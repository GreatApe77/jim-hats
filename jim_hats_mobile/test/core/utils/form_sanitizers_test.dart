import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/utils/form_sanitizers.dart';

void main() {
  test(
    'Should sanitize username',
    () {
      String testUsernameWithSpaces = '   spaced_username   ';
      String expectedResult = 'spaced_username';
      final result = FormSanitizers.sanitizeUsername(testUsernameWithSpaces);
      expect(result, expectedResult);
    },
  );
   test(
    'Should sanitize email',
    () {
      String testEmail = '   email@EMAIL.COM   ';
      String expectedResult = 'email@email.com';
      final result = FormSanitizers.sanitizeEmail(testEmail);
      expect(result, expectedResult);
    },
  );
}
