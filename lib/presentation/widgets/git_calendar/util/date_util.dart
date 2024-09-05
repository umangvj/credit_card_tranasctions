class DateUtil {
  static const int daysInWeek = 7;

  static const List<String> weekLabel = [
    '',
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
  ];

  static DateTime startDayOfMonth(final DateTime referenceDate) =>
      DateTime(referenceDate.year, referenceDate.month, 1);

  static DateTime endDayOfMonth(final DateTime referenceDate) =>
      DateTime(referenceDate.year, referenceDate.month + 1, 0);

  static DateTime oneYearBefore(final DateTime referenceDate) =>
      DateTime(referenceDate.year - 1, referenceDate.month, referenceDate.day);

  static DateTime changeDay(final DateTime referenceDate, final int dayCount) =>
      DateTime(referenceDate.year, referenceDate.month,
          referenceDate.day + dayCount);
}
