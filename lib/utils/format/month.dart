class MonthFormatter {
  static List<String> monthList = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  static List<String> shortMonthList = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sept',
    'Oct',
    'Nov',
    'Dec',
  ];

  static String formatMonth(String month) {
    return monthList[int.parse(month) - 1];
  }

  static String formatShortMonth(String month) {
    return shortMonthList[int.parse(month) - 1];
  }

  static String formatMonthYear(String monthYear) {
    List<String> monthYearList = monthYear.split('-');
    return '${formatMonth(monthYearList[1])} ${monthYearList[0]}';
  }

  static String formatShortMonthYear(String monthYear) {
    List<String> monthYearList = monthYear.split('-');
    return '${formatShortMonth(monthYearList[1])} ${monthYearList[0]}';
  }

  static String formatDateMonthYear(String date) {
    List<String> dateList = date.split('-');
    return '${dateList[2]} ${formatShortMonth(dateList[1])} ${dateList[0]}';
  }

}
