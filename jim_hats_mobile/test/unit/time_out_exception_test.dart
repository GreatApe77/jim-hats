import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/exceptions/time_out_exception.dart';

void main() {
  group(
    'Timeout exception test',
    () {
      final String expectedMessage = 'The Server is taking too long to answer';
      late TimeOutException timeOutException;
      setUp(
        () {
          timeOutException = TimeOutException();
        },
      );
      test(
        'Should display correct message',
        () {
          expect(timeOutException.getMessage(), expectedMessage);
        },
      );
    },
  );
}
