import 'package:aoc2021/src/day14.dart';
import 'package:test/test.dart';

main() {
  group('2021 Day 14', () {
    final exampleInput = '''
NNCB

CH -> B
HH -> N
CB -> H
NH -> C
HB -> C
HC -> B
HN -> C
NN -> C
BH -> H
NC -> B
NB -> B
BN -> B
BB -> N
BC -> B
CC -> N
CN -> C''';

    group('part 1', () {
      test('example', () {
        expect(Day14().part1(exampleInput), 1588);
      });

      test('solution', () => Day14().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day14().part2(exampleInput), 2188189693529);
      });

      test('solution', () => Day14().testPart2());
    });
  });
}
