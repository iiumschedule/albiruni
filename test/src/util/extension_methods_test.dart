import 'package:albiruni/albiruni.dart';
import 'package:test/test.dart';

void main() {
  test('Format course code', () async {
    var x = 'ppbm1331';
    expect(x.toAlbiruniFormat(), 'PPBM 1331');
    x = 'tqb1001m';
    expect(x.toAlbiruniFormat(), 'TQB 1001M');
    x = 'mcte 2110';
    expect(x.toAlbiruniFormat(), 'MCTE 2110');
    x = 'ccdn1352e';
    expect(x.toAlbiruniFormat(), 'CCDN1352E');
  });
}
