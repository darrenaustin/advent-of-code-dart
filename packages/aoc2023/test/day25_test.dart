import 'package:aoc2023/src/day25.dart';
import 'package:test/test.dart';

main() {
  group('2023 Day 25', () {
    final exampleInput = '''
jqt: rhn xhk nvd
rsh: frs pzl lsr
xhk: hfx
cmg: qnr nvd lhk bvb
rhn: xhk bvb hfx
bvb: xhk hfx
pzl: lsr hfx nvd
qnr: nvd
ntq: jqt hfx bvb xhk
nvd: lhk
lsr: lhk
rzs: qnr cmg lsr rsh
frs: qnr lhk lsr''';

    group('part 1', () {
      test('example', () {
        expect(Day25().part1(exampleInput), 54);
      });

      test('solution', () => Day25().testPart1());
    });

    group('part 2', () {
      test('solution', () => Day25().testPart2());
    });
  });
}
