import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/exceptions/http_exceptions.dart';

void main() {
  test(
    'Should display readable toString',
    () {
      final someMessage = 'Error in Http';
      final exception = HttpException(someMessage);
      expect(exception.toString(), 'HttpException: $someMessage');
    },
  );
}
