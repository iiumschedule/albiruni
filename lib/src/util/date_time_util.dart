import 'package:albiruni/src/model/day_time.dart';
import 'package:intl/intl.dart';

/// Utility classes to parse raw data to proper data
class DateTimeUtil {
  /// Map day in String to integers
  static int dayMap(String day) {
    switch (day) {
      case 'MON':
      case 'M':
        return DateTime.monday;
      case 'T':
      case 'TUE':
        return DateTime.tuesday;
      case 'W':
      case 'WED':
        return DateTime.wednesday;
      case 'TH':
      case 'THUR':
        return DateTime.thursday;
      case 'FRI':
        return DateTime.friday;
      case 'SAT':
        return DateTime.saturday;
      case 'SUN':
        return DateTime.sunday;
      default:
        return 99; // invalid day index
    }
  }

  /// Parse weirdly formatted time in String to [DayTime] object
  static DayTime? parseDayTime(String text) {
    bool isAM = text.contains("AM");

    var split = text.split(' - ');
    var tempStartTime = split.first;
    var tempEndTime = split.last.split(" ").first;

    if (!tempStartTime.contains('.')) tempStartTime = '$tempStartTime.00';
    if (!tempEndTime.contains('.')) {
      tempEndTime = '$tempEndTime.00';
    } else {
      // In some cases, time is missing a trailing zero. Example: 4.3 PM
      if (tempEndTime.split('.').last.length <= 1) {
        tempEndTime = '${tempEndTime}0';
      }
    }

    // Formatting of the website is totally messed up,
    // For instance, the website show 12 AM but supposedly it is 12 PM.
    // who goes to class at night???
    if (tempEndTime.contains("12")) isAM = false;

    // cancel if bad time format
    if (split.length < 2) return null;

    var endTime =
        DateFormat('hh.mm a').parse("$tempEndTime ${isAM ? "AM" : "PM"}", true);

    var startTime = DateFormat('hh.mm a')
        .parse("$tempStartTime ${isAM ? "AM" : "PM"}", true);

    if (endTime.isBefore(startTime)) {
      startTime = DateFormat('hh.mm a')
          .parse("$tempStartTime ${isAM ? "PM" : "AM"}", true);
    }

    return DayTime(
        // [day] is just placeholder value, actual value is set in [parseAlbiruniHtml] method
        day: 0,
        startTime: DateFormat("HH:mm").format(startTime),
        endTime: DateFormat("HH:mm").format(endTime));
  }
}
