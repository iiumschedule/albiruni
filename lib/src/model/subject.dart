import 'day_time.dart';

/// Contains useful data for a particular subject.
class Subject {
  /// Course Code. Example: "MCTE 3373"
  late String code;

  /// Name of the course. Example: "INDUSTRIAL AUTOMATION"
  late String title;

  /// Venue. It can be null
  String? venue;

  /// Section
  late int sect;

  /// Credit hour
  late double chr;

  /// List of lecturer(s) teaching the subject
  late List<String> lect;

  /// Day and Time for the class. It can be null.
  late List<DayTime?> dayTime;

  Subject({
    required this.code,
    required this.sect,
    required this.title,
    required this.chr,
    required this.venue,
    required this.lect,
    required this.dayTime,
  });

  Subject.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    sect = json["sect"];
    title = json["title"];
    chr = json["chr"];
    venue = json["venue"];
    lect = List<String>.from(json["lect"]);
    dayTime =
        (json["dayTime"] as List).map((e) => DayTime.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["code"] = code;
    data["sect"] = sect;
    data["title"] = title;
    data["chr"] = chr;
    data["venue"] = venue;
    data["lect"] = lect;
    data["dayTime"] = dayTime;
    return data;
  }

  @override
  String toString() =>
      "{code: $code,sect: $sect, title: $title, chr: $chr ,venue : $venue, lect : $lect, dayTime: $dayTime}";
}
