import 'package:aoc2021/src/day03.dart';
import 'package:test/test.dart';

main() {
  group('2021 Day 03', () {
    final exampleInput = '''
00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010''';
    group('part 1', () {
      test('example', () {
        expect(Day03().part1(exampleInput), 198);
      });

      test('solution', () => Day03().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day03().part2(exampleInput), 230);
      });

      test('solution', () => Day03().testPart2());
    });
  });
}
