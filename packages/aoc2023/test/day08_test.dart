import 'package:aoc2023/src/day08.dart';
import 'package:test/test.dart';

main() {
  group('2023 Day 08', () {
    group('part 1', () {
      final String exampleInput1 = '''
RL

AAA = (BBB, CCC)
BBB = (DDD, EEE)
CCC = (ZZZ, GGG)
DDD = (DDD, DDD)
EEE = (EEE, EEE)
GGG = (GGG, GGG)
ZZZ = (ZZZ, ZZZ)''';
      final String exampleInput2 = '''
LLR

AAA = (BBB, BBB)
BBB = (AAA, ZZZ)
ZZZ = (ZZZ, ZZZ)''';

      test('examples', () {
        expect(Day08().part1(exampleInput1), 2);
        expect(Day08().part1(exampleInput2), 6);
      });

      test('solution', () => Day08().testPart1());
    });

    group('part 2', () {
      final String exampleInput1 = '''
LR

11A = (11B, XXX)
11B = (XXX, 11Z)
11Z = (11B, XXX)
22A = (22B, XXX)
22B = (22C, 22C)
22C = (22Z, 22Z)
22Z = (22B, 22B)
XXX = (XXX, XXX)''';

      test('example', () {
        expect(Day08().part2(exampleInput1), 6);
      });

      test('solution', () => Day08().testPart2());
    });
  });
}
