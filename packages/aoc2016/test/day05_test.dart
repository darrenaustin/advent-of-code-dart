import 'package:aoc2016/src/day05.dart';
import 'package:test/test.dart';

main() {
  group('2016 Day 05', () {
    group('part 1', () {
      test('examples', () {
        expect(Day05().part1('abc'), '18f47a30');
      });

      test('solution', () => Day05().testPart1());
    });

    group('part 2', () {
      test('examples', () {
        expect(Day05().part2('abc'), '05ace8e3');
      });

      test('solution', () => Day05().testPart2());
    });
  });
}
