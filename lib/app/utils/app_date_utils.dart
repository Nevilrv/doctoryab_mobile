class AppDateUtils {
  static int daysOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0).day;
  }
}
