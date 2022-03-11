/// The Day & Time for a subject
class DayTime {
  /// Day in integer. 0 is Sunday, 1 is Monday and so on.
  late int day;

  /// Starting time of the class
  late String startTime;

  /// Ending time of the class.
  late String endTime;

  DayTime({required this.day, required this.startTime, required this.endTime});

  DayTime.fromJson(Map<String, dynamic> json) {
    day = json["day"];
    startTime = json["startTime"];
    endTime = json["endTime"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["day"] = day;
    data["startTime"] = startTime;
    data["endTime"] = endTime;
    return data;
  }

  @override
  get hashCode => '$day, $startTime'.hashCode;

  @override
  bool operator ==(Object other) {
    return other is DayTime &&
        day == other.day &&
        startTime == other.startTime &&
        endTime == other.endTime;
  }

  @override
  String toString() => "{day: $day, startTime: $startTime, endTime: $endTime}";
}

class TempDayTime {
  String day;
  String time;

  TempDayTime({required this.day, required this.time});
}
