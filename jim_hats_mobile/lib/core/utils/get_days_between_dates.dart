int getDaysBetweenDates(DateTime date1, DateTime date2) {
  if (!date2.isAfter(date1)) {
    DateTime aux;
    aux = date1;
    date1 = date2;
    date2 = aux;
  }

  double milisecondDifference = date2.millisecondsSinceEpoch.toDouble() -
      date1.millisecondsSinceEpoch.toDouble();
  double seconds = milisecondDifference / 1000;
  double minutes = seconds / 60;
  double hours = minutes / 60;
  double days = hours / 24;
  return days.toInt();
}
