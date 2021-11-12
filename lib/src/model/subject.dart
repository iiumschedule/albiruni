import 'day_time.dart';

class Subject {
  /// Course Code. Example: "MCTE 3373"
  String code;

  /// Name of the course. Example: "INDUSTRIAL AUTOMATION"
  String title;

  /// Venue. It can be null
  String? venue;

  /// Section
  int sect;

  /// Credit hour
  double chr;

  /// List of lecturer(s) teaching the subject
  List<String> lect;

  /// Day and Time for the class. It can be null.
  List<DayTime?> dayTime;

  Subject({
    required this.code,
    required this.sect,
    required this.title,
    required this.chr,
    required this.venue,
    required this.lect,
    required this.dayTime,
  });

  // For printing to the console
  Map<String, dynamic> get data => {
        'code': code,
        'sect': sect,
        'title': title,
        'chr': chr,
        'venue': venue,
        'lect': lect,
        'dayTime': dayTime
            .map((e) => '${e?.day}, ${e?.startTime}, ${e?.endTime}')
            .toList(),
      };
}
