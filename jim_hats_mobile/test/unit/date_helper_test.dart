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
   test(
    'Should format date Extended similar to: Monday, February 25 14:00',
    () {
      final testDate = DateTime(2013, DateTime.march, 8,14,9);
      final expectedResult = 'Friday, March 8 14:09';
      final result = DateHelper.formatDateExtended(testDate);
      expect(result,expectedResult);
    },
  );

  test(
    'Should format date short similar to: February 4, 2025',
    () {
      final testDate = DateTime(2025, DateTime.february, 4,14,9);
      final expectedResult = 'February 4, 2025';
      final result = DateHelper.formatDateShort(testDate);
      expect(result,expectedResult);
    },
  );
}
