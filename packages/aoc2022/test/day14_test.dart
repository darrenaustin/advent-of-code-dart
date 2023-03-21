import 'package:aoc2022/src/day14.dart';
import 'package:test/test.dart';

main() {
  group('2022 Day 14', () {
    final exampleInput = '''
498,4 -> 498,6 -> 496,6
503,4 -> 502,4 -> 502,9 -> 494,9''';

    group('part 1', () {
      test('example', () {
        expect(Day14().part1(exampleInput), 24);
      });

      test('solution', () => Day14().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day14().part2(exampleInput), 93);
      });

      test('solution', () => Day14().testPart2());
    });
  });
}
