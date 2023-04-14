import 'package:aoc2016/src/day14.dart';
import 'package:test/test.dart';

main() {
  group('2016 Day 14', () {
    group('part 1', () {
      test('example', () {
        expect(Day14().part1('abc'), 22728);
      });

      test('solution', () => Day14().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day14().part2('abc'), 22551);
      });

      test('solution', () => Day14().testPart2());
    });
  });
}
