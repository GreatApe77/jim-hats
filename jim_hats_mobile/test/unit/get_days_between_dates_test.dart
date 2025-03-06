import 'package:flutter_test/flutter_test.dart';
import 'package:jim_hats_mobile/core/utils/get_days_between_dates.dart';

void main() {
  test(
    'Should return days between two dates',
    () {
      DateTime date2003 = DateTime(
        2003,
      );
      DateTime date2004 = DateTime(
        2004,
      );
      int daysBetween = getDaysBetweenDates(date2003,date2004);
      expect(daysBetween,365);
    },
  );
  test(
    'Should return days between two dates (even in different order)',
    () {
      DateTime date2003 = DateTime(
        2003,
      );
      DateTime date2004 = DateTime(
        2004,
      );
      int daysBetween = getDaysBetweenDates(date2004,date2003);
      expect(daysBetween,365);
    },
  );
}
