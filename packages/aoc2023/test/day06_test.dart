import 'package:aoc2023/src/day06.dart';
import 'package:test/test.dart';

main() {
  group('2023 Day 06', () {
    final String exampleInput = '''
Time:      7  15   30
Distance:  9  40  200''';

    group('part 1', () {
      test('example', () {
        expect(Day06().part1(exampleInput), 288);
      });

      test('solution', () => Day06().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day06().part2(exampleInput), 71503);
      });

      test('solution', () => Day06().testPart2());
    });
  });
}
