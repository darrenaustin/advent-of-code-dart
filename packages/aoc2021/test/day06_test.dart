import 'package:aoc2021/src/day06.dart';
import 'package:test/test.dart';

main() {
  group('2021 Day 06', () {
    final exampleInput = '3,4,3,1,2';

    group('part 1', () {
      test('example', () {
        expect(Day06().part1(exampleInput), 5934);
      });

      test('solution', () => Day06().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day06().part2(exampleInput), 26984457539);
      });

      test('solution', () => Day06().testPart2());
    });
  });
}
