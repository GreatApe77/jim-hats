import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/utils/date_helper.dart';

void main() {
  test(
    'Should format date in DD/MM/YYYY',
    () {
      final testDate = DateTime(2099, DateTime.november, 21);

      final expectedResult = '21/11/2099';
      final result= DateHelper.formatDateSlashSeparated(testDate);

      expect(result, expectedResult);
    },
  );
  test(
    'Should format date in DD/MM/YYYY (day and month less than 10)',
    () {
      final testDate = DateTime(2099, DateTime.january, 9);

      final expectedResult = '09/01/2099';
      final result= DateHelper.formatDateSlashSeparated(testDate);

      expect(result, expectedResult);
    },
  );
}
