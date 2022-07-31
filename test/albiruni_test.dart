import 'package:albiruni/albiruni.dart';
import 'package:test/test.dart';

void main() {
  test('Reachability', () async {
    final albiruni =
        await Albiruni(session: "2021/2022", semester: 1).fetch("AED");
    print('Content length: ${albiruni.length}');
    expect(albiruni, isNotEmpty);
  });

  test('Reachability proxy', () async {
    final albiruni = await Albiruni(session: "2021/2022", semester: 1)
        .fetch("ECONS", useProxy: true);
    print('Content length: ${albiruni.length}');
    expect(albiruni, isNotEmpty);
  });

  test('format input', () {
    List<String> examples = [
      "mcte3103",
      "rkud4995",
      "tqb 2011 e",
      "tq   3001",
      "BMCO 1105"
    ];
    List<String> expectedOutput = [
      "MCTE 3103",
      "RKUD 4995",
      "TQB 2011E",
      "TQ 3001",
      "BMCO 1105"
    ];

    for (int i = 0; i < examples.length; i++) {
      expect(examples[i].toAlbiruniFormat(), expectedOutput[i]);
    }
  });
}
