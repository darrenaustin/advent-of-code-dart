import 'package:aoc2017/src/day06.dart';
import 'package:test/test.dart';

main() {
  group('2017 Day 06', () {
    final exampleInput = '0 2 7 0';

    group('part 1', () {
      test('example', () {
        expect(Day06().part1(exampleInput), 5);
      });

      test('solution', () => Day06().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day06().part2(exampleInput), 4);
      });

      test('solution', () => Day06().testPart2());
    });
  });
}
