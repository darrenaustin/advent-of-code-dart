import 'package:aoc2020/src/day18.dart';
import 'package:test/test.dart';

main() {
  group('2020 Day 18', () {
    group('part 1', () {
      test('examples', () {
        expect(Day18().part1('1 + 2 * 3 + 4 * 5 + 6'), 71);
        expect(Day18().part1('1 + (2 * 3) + (4 * (5 + 6))'), 51);
        expect(Day18().part1('2 * 3 + (4 * 5)'), 26);
        expect(Day18().part1('5 + (8 * 3 + 9 + 3 * 4 * 3)'), 437);
        expect(
            Day18().part1('5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))'), 12240);
        expect(Day18().part1('((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2'),
            13632);
      });

      test('solution', () => Day18().testPart1());
    });

    group('part 2', () {
      test('examples', () {
        expect(Day18().part2('1 + 2 * 3 + 4 * 5 + 6'), 231);
        expect(Day18().part2('1 + (2 * 3) + (4 * (5 + 6))'), 51);
        expect(Day18().part2('2 * 3 + (4 * 5)'), 46);
        expect(Day18().part2('5 + (8 * 3 + 9 + 3 * 4 * 3)'), 1445);
        expect(
            Day18().part2('5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))'), 669060);
        expect(Day18().part2('((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2'),
            23340);
      });

      test('solution', () => Day18().testPart2());
    });
  });
}
