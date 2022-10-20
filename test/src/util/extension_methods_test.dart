import 'package:albiruni/albiruni.dart';
import 'package:test/test.dart';

void main() {
  test('Format course code', () async {
    List<String> examples = [
      "mcte3103",
      "rkud4995",
      "tqb 2011 e",
      "tq   3001",
      "BMCO 1105",
      "ppbm1331",
      "tqb1001m",
      "mcte 2110",
      "ccdn1352e"
    ];
    List<String> expectedOutput = [
      "MCTE 3103",
      "RKUD 4995",
      "TQB 2011E",
      "TQ 3001",
      "BMCO 1105",
      "PPBM 1331",
      "TQB 1001M",
      "MCTE 2110",
      "CCDN1352E",
    ];
    for (int i = 0; i < examples.length; i++) {
      expect(examples[i].toAlbiruniFormat(), expectedOutput[i]);
    }
  });
}
