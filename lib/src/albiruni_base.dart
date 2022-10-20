import 'package:albiruni/albiruni.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

import 'model/day_time.dart';
import 'util/date_time_util.dart';

/// Albiruni scrapper.
///
/// Base code are ported from https://github.com/PlashSpeed-Aiman/IIUMCourseScheduleApp
class Albiruni {
  // a.k.a year.
  ///
  /// Example: "2020/2021", "2021/2022", etc.
  ///
  /// Refer to: http://albiruni.iium.edu.my/myapps/StudentOnline/schedule1.php
  String session;

  /// Example: 1, 2, 3
  ///
  /// Some kuliiyah may not have semester 3.
  int semester;

  /// Short version of session
  ///
  /// Example: "20/21" etc.
  late String sesShort;

  /// Study grade [ug] for Undergraduate, [pg] for Postgraduate
  late StudyGrad studyGrade;

  late final String _basicParams;

  // Instantiate Albiruni object. All parameters are required.
  Albiruni({
    required this.semester,
    required this.session,
    this.studyGrade = StudyGrad.ug,
  }) : super() {
    _basicParams = "?action=view"
            "&sem=" +
        semester.toString() +
        "&ses=" +
        session +
        "&ctype=" +
        (studyGrade == StudyGrad.ug ? "<" : ">=");
    sesShort = session.split('/').first.substring(2) +
        '/' +
        session.split('/').last.substring(2);
  }

  final _baseUrl = 'albiruni.iium.edu.my/myapps/StudentOnline/schedule1.php';
  final _proxyUrl = 'corsproxyuia.up.railway.app/';

  /// Fetch a list of subjects based on your specification.
  ///
  /// [course] is optional. Example: "AAD 3190", "MCTE 3312". The 4 digit number can be omitted. Example: "EECE".
  ///
  /// One page holds about 50 entries. Navigate to the next page using the [page] parameter. Default is `1`.
  ///
  /// if [useProxy] is set to true, request to albiruni will go through a proxy server. Useful when using dealing with CORS issue.
  Future<List<Subject>> fetch(String kulliyah,
      {String? course, int page = 1, bool useProxy = false}) async {
    if (course != null) {
      course.replaceFirst(' ', '+').toUpperCase();
    } else {
      course = '';
    }
    var extraParams = "&kuly=" +
        kulliyah +
        "&view=" +
        (page * 50).toString() +
        "&course=" +
        course;

    var finalUrl =
        'https://${useProxy ? _proxyUrl : ''}$_baseUrl$_basicParams$extraParams';
    // print('Query URL: $finalUrl');

    List<Subject> _subjects = [];
    var res = await http.get(Uri.parse(finalUrl));
    var document = parse(res.body);
    var elements = document.getElementsByTagName("tbody");

    // catching error that usually occur when searching
    // subject that is not available to the current scope.
    try {
      elements = elements[1].children;
    } on RangeError {
      throw EmptyBodyException(
          message: "Body is empty. Subject not found/offered");
    }

    // Iteratoing each row to parse the contents
    for (var i = 2; i < elements.length - 1; i++) {
      var code = elements[i].getElementsByTagName("td")[0].text;
      var sect = elements[i].getElementsByTagName("td")[1].text;
      var title = elements[i].getElementsByTagName("td")[2].text;
      var chr = elements[i].getElementsByTagName("td")[3].text;
      var data = elements[i]
          .getElementsByTagName("td")[4]
          .getElementsByTagName("tbody")
          .first
          .querySelectorAll('tr');

      var day = data
          .map((e) => e.getElementsByTagName('td').elementAt(0).text)
          .toList();

      var time = data
          .map((e) => e.getElementsByTagName('td').elementAt(1).text)
          .toList();

      var venue =
          data.map((e) => e.getElementsByTagName('td').elementAt(2).text).first;

      var lect = data
          .map((e) => e.getElementsByTagName('td').elementAt(3).text)
          .where((element) => element.isNotEmpty) // remove empty rows
          .toList();

      List<DayTime?> dayTime = [];
      // Check if day or time value is empty
      // Only process day & time if they're exist
      if (!(time.first.trim().isEmpty || day.first.trim().isEmpty)) {
        List<TempDayTime> tempDayTime = [];

        // Combine the day & time into DayTime object
        for (var i = 0; i < day.length; i++) {
          tempDayTime.add(TempDayTime(day: day[i], time: time[i]));
        }

        // for every day, save it with their time
        for (var i = 0; i < tempDayTime.length; i++) {
          var days = tempDayTime[i].day.split('-');
          var parsedDayTime = DateTimeUtil.parseDayTime(tempDayTime[i].time);
          if (parsedDayTime == null) continue; // ignore if no value to pase
          var dts = days.map((day) => DayTime(
              day: DateTimeUtil.dayMap(day),
              startTime: parsedDayTime.startTime,
              endTime: parsedDayTime.endTime));
          dayTime.addAll(dts);
        }
      }

      _subjects.add(
        Subject(
          code: code,
          sect: int.parse(sect),
          title: title,
          chr: double.parse(chr),
          venue: venue == '-' ? null : venue,
          lect: lect,
          dayTime: dayTime.toSet().toList()
            ..sort((a, b) => a!.day.compareTo(b!.day)),
          // remove duplicated DayTime
          // and sort the day (ie, Monday should come first and so on)
        ),
      );
    }
    if (_subjects.isEmpty) {
      throw NoSubjectsException(
          message:
              "No subjects found on this page. Reason included but not limited to 1) You may have passed the end of the pages 2) Course is not offered 3) Searching cours in wrong Kuliyyah/semester");
    }
    return _subjects;
  }

  /// Check if subject on the current scope (kulliyah, semester & session) is available.
  ///
  /// `true` will return if there is atleast one subject in the current scope.
  Future<bool> preflight(String kulliyah) async {
    var firstPage = "&view=50";
    var kull = "&kuly=$kulliyah";
    var res = await http.get(
        Uri.parse('https://' + _baseUrl + _basicParams + kull + firstPage));
    var document = parse(res.body);
    var elements = document.getElementsByTagName("tbody");

    // Just like in fetch()
    try {
      elements = elements[1].children;
    } on RangeError {
      return false;
    }

    // If no error, consider the is a data
    return true;
  }
}
