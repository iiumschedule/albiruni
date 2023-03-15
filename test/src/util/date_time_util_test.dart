import 'package:albiruni/src/util/date_time_util.dart';
import 'package:albiruni/src/util/exceptions.dart';
import 'package:test/test.dart';

void main() {
  group('Day parsing', () {
    test('Parse days from raw', () {
      /**
       * Single day
       */

      var rawDay = 'MON';
      var resDay = DateTimeUtil.parseDays(rawDay);
      expect(resDay, [DateTime.monday]);

      rawDay = 'FRI';
      resDay = DateTimeUtil.parseDays(rawDay);
      expect(resDay, [DateTime.friday]);

      /**
       * Compound days
       */

      rawDay = 'M-W'; // Monday & Wednesday
      resDay = DateTimeUtil.parseDays(rawDay);
      expect(resDay, [DateTime.monday, DateTime.wednesday]);

      rawDay = 'T-TH'; // Tuesday & Thursday
      resDay = DateTimeUtil.parseDays(rawDay);
      expect(resDay, [
        DateTime.tuesday,
        DateTime.thursday,
      ]);

      rawDay = 'F-SAT'; // Tuesday & Thursday
      resDay = DateTimeUtil.parseDays(rawDay);
      expect(resDay, [
        DateTime.friday,
        DateTime.saturday,
      ]);

      /**
       * Special cases
       */
      rawDay = 'MTWTH';
      resDay = DateTimeUtil.parseDays(rawDay);
      expect(resDay, [
        DateTime.monday,
        DateTime.tuesday,
        DateTime.wednesday,
        DateTime.thursday
      ]);

      rawDay = 'MTWTHF';
      resDay = DateTimeUtil.parseDays(rawDay);
      expect(resDay, [
        DateTime.monday,
        DateTime.tuesday,
        DateTime.wednesday,
        DateTime.thursday,
        DateTime.friday
      ]);

      rawDay = 'MTW';
      resDay = DateTimeUtil.parseDays(rawDay);
      expect(resDay, [
        DateTime.monday,
        DateTime.tuesday,
        DateTime.wednesday,
      ]);

      /**
       * Invalid
       */
      rawDay = 'MEOW';
      expect(() => DateTimeUtil.parseDays(rawDay),
          throwsA(isA<DayTimeParseException>()));
    });
  });

  group('Time parsing', () {
    test('Normal | AM', () {
      String rawTime = '8.30 - 9.50 AM';
      var resTime = DateTimeUtil.parseTime(rawTime);
      expect(resTime!.startTime, isNot('8:30'));
      expect(resTime.startTime, '08:30'); // must have leading zero
      expect(resTime.endTime, '09:50');
    });
    test('Normal | PM', () {
      String rawTime = '3.30 - 5.20 PM';
      var resTime = DateTimeUtil.parseTime(rawTime);
      expect(resTime!.startTime, isNot('3:30'));
      expect(resTime.startTime, '15:30'); // must 24 hour formatted
      expect(resTime.endTime, '17:20');
    });

    test('Start time single digit | PM', () {
      String rawTime = '2 - 4.50 PM';
      var resTime = DateTimeUtil.parseTime(rawTime);
      expect(resTime!.startTime, '14:00');
      expect(resTime.endTime, '16:50');
    });

    test('Single digit | PM', () {
      String rawTime = '8 - 10 PM';
      var resTime = DateTimeUtil.parseTime(rawTime);
      expect(resTime!.startTime, '20:00');
      expect(resTime.endTime, '22:00');
    });

    group('Startime in AM but endtime in PM', () {
      test('Exhibit A', () {
        String rawTime = '11.30 - 12.50 AM';
        var resTime = DateTimeUtil.parseTime(rawTime);
        expect(resTime!.startTime, '11:30');
        expect(resTime.endTime, '12:50');
      });
      test('Exhibit B (Issue #5)', () {
        String rawTime = '11.30 - 1.20 AM';
        var resTime = DateTimeUtil.parseTime(rawTime);
        expect(resTime!.startTime, '11:30');
        expect(resTime.endTime, '13:20');
      },
          skip:
              'Not implemented yet. It is a albiruni\'s fault. See https://github.com/iqfareez/albiruni/issues/5#issuecomment-1283678013');
    });
  });
}
