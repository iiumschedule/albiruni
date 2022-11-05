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

  group('Time parsing', () {
    test('Normal | AM', () {
      String rawTime = '8.30 - 9.50 AM';
      var resTime = DateTimeUtil.parseDayTime(rawTime);
      expect(resTime!.startTime, isNot('8:30'));
      expect(resTime.startTime, '08:30'); // must have leading zero
      expect(resTime.endTime, '09:50');
    });
    test('Normal | PM', () {
      String rawTime = '3.30 - 5.20 PM';
      var resTime = DateTimeUtil.parseDayTime(rawTime);
      expect(resTime!.startTime, isNot('3:30'));
      expect(resTime.startTime, '15:30'); // must 24 hour formatted
      expect(resTime.endTime, '17:20');
    });

    test('Start time single digit | PM', () {
      String rawTime = '2 - 4.50 PM';
      var resTime = DateTimeUtil.parseDayTime(rawTime);
      expect(resTime!.startTime, '14:00');
      expect(resTime.endTime, '16:50');
    });

    test('Single digit | PM', () {
      String rawTime = '8 - 10 PM';
      var resTime = DateTimeUtil.parseDayTime(rawTime);
      expect(resTime!.startTime, '20:00');
      expect(resTime.endTime, '22:00');
    });

    group('Startime in AM but endtime in PM', () {
      test('Exhibit A', () {
        String rawTime = '11.30 - 12.50 AM';
        var resTime = DateTimeUtil.parseDayTime(rawTime);
        expect(resTime!.startTime, '11:30');
        expect(resTime.endTime, '12:50');
      });
      test('Exhibit B (Issue #5)', () {
        String rawTime = '11.30 - 1.20 AM';
        var resTime = DateTimeUtil.parseDayTime(rawTime);
        expect(resTime!.startTime, '11:30');
        expect(resTime.endTime, '13:20');
      },
          skip:
              'Not implemented yet. It is a albiruni\'s fault. See https://github.com/iqfareez/albiruni/issues/5#issuecomment-1283678013');
    });
  });
}
