abstract class DateHelper {
  static const Map<int, String> monthNumberToName = {
    1: 'January',
    2: 'February',
    3: 'March',
    4: 'April',
    5: 'May',
    6: 'June',
    7: 'July',
    8: 'August',
    9: 'September',
    10: 'October',
    11: 'November',
    12: 'December',
  };
  static const Map<int, String> weekDayToName = {
    1: 'Monday',
    2: 'Tuesday',
    3: 'Wednesday',
    4: 'Thursday',
    5: 'Friday',
    6: 'Saturday',
    7: 'Sunday',
  };
  ///Example: February 4, 2025
  static String formatDateShort(DateTime date) {
    return '${monthNumberToName[date.month]} ${date.day}, ${date.year}';
  }
  static String formatDateExtended(DateTime date){
    return '${weekDayToName[date.weekday]}, ${monthNumberToName[date.month]} ${date.day} ${date.hour}:${date.minute}';
    //return '${}'
  }
}
