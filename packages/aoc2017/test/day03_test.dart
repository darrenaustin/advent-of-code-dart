import 'package:aoc2017/src/day03.dart';
import 'package:test/test.dart';

main() {
  group('2017 Day 03', () {
    group('part 1', () {
      test('example', () {
        expect(Day03().part1('1'), 0);
        expect(Day03().part1('12'), 3);
        expect(Day03().part1('23'), 2);
        expect(Day03().part1('1024'), 31);
      });

      test('solution', () => Day03().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day03().part2('1'), 2);
        expect(Day03().part2('12'), 23);
        expect(Day03().part2('23'), 25);
        expect(Day03().part2('1024'), 1968);
      });

      test('solution', () => Day03().testPart2());
    });
  });
}
