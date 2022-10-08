import 'dart:convert';

import 'package:albiruni/albiruni.dart';
import 'package:test/test.dart';

void main() {
  test('Parse day time from json', () async {
    var myJson = '''
                {
                  "day": 0,
                  "startTime" : "09:20",
                  "endTime" : "10:40"
                }
                ''';
    var dayTime = DayTime.fromJson(jsonDecode(myJson));
    expect(dayTime.runtimeType, DayTime);
    expect(dayTime.day, 0);
    expect(dayTime.startTime, '09:20');
    expect(dayTime.endTime, '10:40');
  });

  test('Convert DayTime to Json', () {
    var myDayTime = DayTime(day: 2, startTime: '11:15', endTime: '15:45');
    var myJson = myDayTime.toJson();

    expect(myJson, containsPair('day', equals(2)));
    expect(myJson, containsPair('startTime', equals('11:15')));
    expect(myJson, containsPair('endTime', equals('15:45')));
  });

  test('Compare similar dayTime', () {
    var dt1 = DayTime(day: 2, startTime: '11:15', endTime: '15:45');
    var dt2 = DayTime(day: 2, startTime: '11:15', endTime: '15:45');

    expect(dt1, equals(dt2));
    expect(dt1 == dt2, true); // uses in app, although look similar to equals
  });
}
