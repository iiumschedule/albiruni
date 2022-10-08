import 'package:albiruni/src/util/date_time_util.dart';
import 'package:test/test.dart';

void main() {
  test('Parse dayMap from albiruni day', () {
    // Monday
    var albiruniDay = 'MON';
    var resDay = DateTimeUtil.dayMap(albiruniDay);
    expect(resDay, DateTime.monday);

    // Tuesday
    albiruniDay = 'T';
    resDay = DateTimeUtil.dayMap(albiruniDay);
    expect(resDay, DateTime.tuesday);

    albiruniDay = 'TUE';
    resDay = DateTimeUtil.dayMap(albiruniDay);
    expect(resDay, DateTime.tuesday);

    // Wednesday
    albiruniDay = 'W';
    resDay = DateTimeUtil.dayMap(albiruniDay);
    expect(resDay, DateTime.wednesday);

    albiruniDay = 'WED';
    resDay = DateTimeUtil.dayMap(albiruniDay);
    expect(resDay, DateTime.wednesday);

    // Thursday
    albiruniDay = 'TH';
    resDay = DateTimeUtil.dayMap(albiruniDay);
    expect(resDay, DateTime.thursday);

    albiruniDay = 'THUR';
    resDay = DateTimeUtil.dayMap(albiruniDay);
    expect(resDay, DateTime.thursday);

    // Friday
    albiruniDay = 'FRI';
    resDay = DateTimeUtil.dayMap(albiruniDay);
    expect(resDay, DateTime.friday);

    // Saturday
    albiruniDay = 'SAT';
    resDay = DateTimeUtil.dayMap(albiruniDay);
    expect(resDay, DateTime.saturday);

    // Sunday
    albiruniDay = 'SUN';
    resDay = DateTimeUtil.dayMap(albiruniDay);
    expect(resDay, DateTime.sunday);

    // invalid
    albiruniDay = 'MEOW';
    resDay = DateTimeUtil.dayMap(albiruniDay);
    expect(resDay, isNot(DateTime.monday));
  });
}
