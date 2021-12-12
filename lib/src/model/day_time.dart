/// The Day & Time for a subject
class DayTime {
  /// Day in integer. 0 is Sunday, 1 is Monday and so on.
  int day;

  /// Starting time of the class
  String startTime;

  /// Ending time of the class.
  String endTime;

  DayTime({required this.day, required this.startTime, required this.endTime});

  Map<String, dynamic> get read =>
      {'day': day, 'startTime': startTime, 'endTime': endTime};

  @override
  get hashCode => '$day, $startTime'.hashCode;

  @override
  bool operator ==(Object other) {
    return other is DayTime &&
        day == other.day &&
        startTime == other.startTime &&
        endTime == other.endTime;
  }
}

class TempDayTime {
  String day;
  String time;

  TempDayTime({required this.day, required this.time});
}
