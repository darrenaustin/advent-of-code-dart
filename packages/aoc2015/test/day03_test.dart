import 'package:aoc2015/src/day03.dart';
import 'package:test/test.dart';

main() {
  group('2015 Day 03', () {
    group('part 1', () {
      test('examples', () {
        expect(Day03().part1('>'), 2);
        expect(Day03().part1('^v^v^v^v^v'), 2);
      });

      test('solution', () => Day03().testPart1());
    });

    group('part 2', () {
      test('examples', () {
        expect(Day03().part2('^v'), 3);
        expect(Day03().part2('^>v<'), 3);
        expect(Day03().part2('^v^v^v^v^v'), 11);
      });

      test('solution', () => Day03().testPart2());
    });
  });
}
