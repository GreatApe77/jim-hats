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
  static String formatDateToReadableText(DateTime date) {
    return '${monthNumberToName[date.month]} ${date.day}, ${date.year}';
  }
}
