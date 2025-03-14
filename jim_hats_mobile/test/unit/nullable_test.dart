import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/utils/nullable.dart';

void main() {
  test(
    'Should initialize with empty value',
    () {
      Nullable<dynamic> sup = Nullable(null);
      expect(sup.value, null);
    },
  );

  test(
    'Should initialize with a value of T type',
    () {
      Nullable<int> sup = Nullable<int>(99);
      expect(sup.value, isA<int>());
    },
  );
}
