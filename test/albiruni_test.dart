import 'package:albiruni/albiruni.dart';
import 'package:test/test.dart';

void main() {
  test('Reachability', () async {
    final awesome =
        await Albiruni(kulliyah: "AED", session: "2020/2021", semester: 1)
            .fetch();
    expect(awesome, isNotEmpty);
  });
}
