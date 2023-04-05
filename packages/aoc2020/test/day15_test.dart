import 'package:aoc2020/src/day15.dart';
import 'package:test/test.dart';

main() {
  group('2020 Day 15', () {
    group('part 1', () {
      test('examples', () {
        expect(Day15().part1('0,3,6'), 436);
        expect(Day15().part1('1,3,2'), 1);
        expect(Day15().part1('2,1,3'), 10);
        expect(Day15().part1('1,2,3'), 27);
        expect(Day15().part1('2,3,1'), 78);
        expect(Day15().part1('3,2,1'), 438);
        expect(Day15().part1('3,1,2'), 1836);
      });

      test('solution', () => Day15().testPart1());
    });

    group('part 2', () {
      test('examples', () {
        expect(Day15().part2('0,3,6'), 175594);
        expect(Day15().part2('1,3,2'), 2578);
        expect(Day15().part2('2,1,3'), 3544142);
        expect(Day15().part2('1,2,3'), 261214);
        expect(Day15().part2('2,3,1'), 6895259);
        expect(Day15().part2('3,2,1'), 18);
        expect(Day15().part2('3,1,2'), 362);
      });

      test('solution', () => Day15().testPart2());
    });
  });
}
