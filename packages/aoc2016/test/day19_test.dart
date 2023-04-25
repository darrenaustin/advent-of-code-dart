import 'package:aoc2016/src/day19.dart';
import 'package:test/test.dart';

main() {
  group('2016 Day 19', () {
    group('part 1', () {
      test('example', () {
        expect(Day19().part1('5'), 3);
      });

      test('solution', () => Day19().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day19().part2('5'), 2);
      });

      test('solution', () => Day19().testPart2());
    });
  });
}
