class HelperFunctions {
  String getDayWord(int days) {
    if (days % 10 == 1 && days % 100 != 11) return 'день';
    if ([2, 3, 4].contains(days % 10) && ![12, 13, 14].contains(days % 100))
      return 'дня';
    return 'дней';
  }

  String getHourWord(int hours) {
    if (hours % 10 == 1 && hours % 100 != 11) return 'час';
    if ([2, 3, 4].contains(hours % 10) && ![12, 13, 14].contains(hours % 100))
      return 'часа';
    return 'часов';
  }

  String getMinuteWord(int minutes) {
    if (minutes % 10 == 1 && minutes % 100 != 11) return 'минута';
    if ([2, 3, 4].contains(minutes % 10) &&
        ![12, 13, 14].contains(minutes % 100)) return 'минуты';
    return 'минут';
  }

  String timeAgo(String dateString) {
    DateTime now = DateTime.now();
    DateTime dateTime = DateTime.parse(dateString);
    Duration difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} ${getDayWord(difference.inDays)} назад';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${getHourWord(difference.inHours)} назад';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${getMinuteWord(difference.inMinutes)} назад';
    } else {
      return 'только что';
    }
  }
}
