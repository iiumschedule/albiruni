import 'dart:io';

import 'package:albiruni/albiruni.dart';
import 'package:test/test.dart';

void main() {
  test('Reachability', () async {
    late List<Subject> albiruni;
    try {
      (albiruni, _) =
          await Albiruni(session: "2021/2022", semester: 1).fetch("AED");
    } on HandshakeException catch (e) {
      print("Might be albiruni cert error. $e");
      return;
    }
    print('Content length: ${albiruni.length}');
    expect(albiruni, isNotEmpty);
  });

  test('Reachability proxy', () async {
    final (albiruni, _) = await Albiruni(session: "2021/2022", semester: 1)
        .fetch("ECONS", useProxy: true);
    print('Content length: ${albiruni.length}');
    expect(albiruni, isNotEmpty);
  });
}
