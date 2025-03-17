import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/utils/application_exception.dart';

class _MockApplicationException extends ApplicationException {}

void main() {
  group(
    'Abstract ApplicationException tests',
    () {
      // ignore: no_leading_underscores_for_local_identifiers
      late ApplicationException _mockApplicationException;

      setUp(
        () {
          _mockApplicationException = _MockApplicationException();
        },
      );

      test(
        'Should initialize with standard message',
        () {
          String expectedInitializationMethod = 'Application Exception';
          String message = _mockApplicationException.getMessage();
          expect(message, expectedInitializationMethod);
        },
      );
    },
  );
}
