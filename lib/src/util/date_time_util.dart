import 'package:albiruni/albiruni.dart';
import 'package:intl/intl.dart';

/// Utility classes to parse raw data to proper data
class DateTimeUtil {
  /// Map day in String to DateTime day integer
  /// Return null if cannot parse
  static int? _dayMap(String day) {
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
      case 'F':
      case 'FRI':
        return DateTime.friday;
      case 'SAT':
        return DateTime.saturday;
      case 'SUN':
        return DateTime.sunday;
      default:
        return null;
    }
  }

  /// Parse the given raw day format and return a Day number. If failed to parse,
  /// it will return empty list
  ///
  /// Eg: Given 'MON', return [DateTime.monday]
  static List<int> parseDays(String rawDay) {
    rawDay = rawDay.trim(); // remove all whitespaces (just in case)

    // Attempt to parse single day
    final resultDay = _dayMap(rawDay);
    if (resultDay != null) return [resultDay];

    // Attempt to hyphen-seperated compound days
    var days = rawDay.split('-'); // split 'M-W' to ['M', 'W']
    final resultDays =
        days.map((e) => _dayMap(e)).where((e) => e != null).toList();
    if (resultDays.isNotEmpty) return resultDays.map((e) => e!).toList();

    // Attempt to non-hyphen-seperated compound days

    // check for special cases (https://github.com/iqfareez/albiruni/issues/1)

    List<int> complexCompoundResult = [];
    int i = 0;

    while (i < rawDay.length) {
      // Check for two-character day codes first (like 'TH' or 'SU')
      if (i < rawDay.length - 1 &&
          _dayMap(rawDay.substring(i, i + 2)) != null) {
        complexCompoundResult.add(_dayMap(rawDay.substring(i, i + 2))!);
        i += 2;
      } else {
        // Otherwise, check for one-character day codes
        if (_dayMap(rawDay[i]) != null) {
          complexCompoundResult.add(_dayMap(rawDay[i])!);
        }
        i += 1;
      }
    }

    if (complexCompoundResult.isNotEmpty) return complexCompoundResult;

    return [];
  }

  /// Parse weirdly formatted time in String to [DayTime] object
  static DayTime? parseTime(String text) {
    bool isAM = text.contains("AM");

    var split = text.split(' - ');
    var tempStartTime = split.first;
    var tempEndTime = split.last.split(" ").first;

    // Convert colon format to dot format
    tempStartTime = tempStartTime.replaceAll(':', '.');
    tempEndTime = tempEndTime.replaceAll(':', '.');

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
