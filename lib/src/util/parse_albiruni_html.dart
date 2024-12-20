import 'package:albiruni/src/model/day_time.dart';
import 'package:albiruni/src/util/date_time_util.dart';
import 'package:albiruni/src/util/exceptions.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

import '../model/subject.dart';

/// Parse raw Albiruni body (HTML) to list of [Subject]
(List<Subject>, int) parseAlbiruniHtml(String htmlBody) {
  List<Subject> subjects = [];
  var document = parse(htmlBody);
  var elements = document.getElementsByTagName("tbody");

  // catching error that usually occur when searching
  // subject that is not available to the current scope.
  try {
    elements = elements[1].children; // table content
  } on RangeError {
    throw EmptyBodyException(
        message: "Body is empty. Subject not found/offered");
  }

  int totalPages = parseTotalPages(elements[0]);

  // Iterating each row to parse the contents
  for (var i = 2; i < elements.length - 1; i++) {
    Subject res = parseSubject(elements[i]);
    subjects.add(res);
  }
  if (subjects.isEmpty) {
    throw NoSubjectsException(
        message:
            "No subjects found on this page. Reason included but not limited to 1) You may have passed the end of the pages 2) Course is not offered 3) Searching cours in wrong Kuliyyah/semester");
  }
  return (subjects, totalPages);
}

/// Parse single subject from HTML element
Subject parseSubject(Element element) {
  var code = element.getElementsByTagName("td")[0].text;
  var sect = element.getElementsByTagName("td")[1].text;
  var title = element.getElementsByTagName("td")[2].text;
  var chr = element.getElementsByTagName("td")[3].text;
  var data = element
      .getElementsByTagName("td")[4]
      .getElementsByTagName("tbody")
      .first
      .querySelectorAll('tr');

  var day =
      data.map((e) => e.getElementsByTagName('td').elementAt(0).text).toList();

  var time =
      data.map((e) => e.getElementsByTagName('td').elementAt(1).text).toList();

  var venue =
      data.map((e) => e.getElementsByTagName('td').elementAt(2).text).first;

  var lect = data
      .map((e) => e.getElementsByTagName('td').elementAt(3).text)
      .where((element) => element.isNotEmpty) // remove empty rows
      .toList();

  // https://github.com/iqfareez/albiruni/issues/1#issuecomment-1470978605
  // remove empty entity in a list
  // For eg: [3.30 - 4.30 PM,  ]
  day.removeWhere((element) => element.trim().isEmpty);
  time.removeWhere((element) => element.trim().isEmpty);

  List<DayTime?> dayTime = [];
  // Only process day & time if they're exist
  if (day.isNotEmpty && time.isNotEmpty) {
    List<TempDayTime> tempDayTime = [];

    // Combine the day & time into DayTime object
    for (var i = 0; i < day.length; i++) {
      tempDayTime.add(TempDayTime(day: day[i], time: time[i]));
    }

    // for every day, save it with their time
    for (var i = 0; i < tempDayTime.length; i++) {
      var days = DateTimeUtil.parseDays(tempDayTime[i].day);
      var parsedDayTime = DateTimeUtil.parseTime(tempDayTime[i].time);

      if (parsedDayTime == null) continue; // ignore if no value to pase

      var dts = days.map((day) => DayTime(
          day: day,
          startTime: parsedDayTime.startTime,
          endTime: parsedDayTime.endTime));
      dayTime.addAll(dts);
    }
  }

  return Subject(
    code: code,
    sect: int.parse(sect),
    title: title,
    chr: double.parse(chr),
    venue: venue == '-' ? null : venue,
    lect: lect,
    dayTime: dayTime.toSet().toList()..sort((a, b) => a!.day.compareTo(b!.day)),
    // remove duplicated DayTime
    // and sort the day (ie, Monday should come first and so on)
  );
}

/// Parse total pages from a scope
///
/// JS equivalent:
/// var tdElement = document.getElementsByTagName("tbody")[1].children[0].querySelector("td[colspan]");
/// var aElements = tdElement.querySelectorAll("a");
/// Array.prototype.filter.call(tdElement.children, function(child) {
///   return child.nodeName === "A";
/// }).length;
int parseTotalPages(Element element) {
  var res = element
      .querySelector("td")!
      .children
      .where((element) => element.localName == "a")
      .length;

  // When no <a> element exist, which means this scope has no other pages, only one page
  return res == 0 ? 1 : res;
}
