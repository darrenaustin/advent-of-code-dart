import 'package:aoc2018/src/day01.dart';
import 'package:test/test.dart';

main() {
  group('2018 Day 01', () {
    group('part 1', () {
      test('examples', () {
        expect(Day01().part1('+1 -2 +3 +1'), 3);
        expect(Day01().part1('+1 +1 +1'), 3);
        expect(Day01().part1('-1 -2 -3'), -6);
      });

      test('solution', () => Day01().testPart1());
    });

    group('part 2', () {
      test('examples', () {
        expect(Day01().part2('+1 -2 +3 +1'), 2);
        expect(Day01().part2('+1 -1'), 0);
        expect(Day01().part2('+3 +3 +4 -2 -4'), 10);
        expect(Day01().part2('-6 +3 +8 +5 -6'), 5);
        expect(Day01().part2('+7 +7 -2 -7 -4'), 14);
      });

      test('solution', () => Day01().testPart2());
    });
  });
}
