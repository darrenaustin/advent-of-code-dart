import 'package:aoc2023/src/day15.dart';
import 'package:test/test.dart';

main() {
  group('2023 Day 15', () {
    final exampleInput = '''
rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7''';

    group('part 1', () {
      test('example', () {
        expect(Day15().part1(exampleInput), 1320);
      });

      test('solution', () => Day15().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day15().part2(exampleInput), 145);
      });

      test('solution', () => Day15().testPart2());
    });
  });
}
