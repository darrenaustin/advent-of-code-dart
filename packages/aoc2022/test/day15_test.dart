import 'package:aoc2022/src/day15.dart';
import 'package:test/test.dart';

main() {
  group('2022 Day 15', () {
    final exampleInput = '''
Sensor at x=2, y=18: closest beacon is at x=-2, y=15
Sensor at x=9, y=16: closest beacon is at x=10, y=16
Sensor at x=13, y=2: closest beacon is at x=15, y=3
Sensor at x=12, y=14: closest beacon is at x=10, y=16
Sensor at x=10, y=20: closest beacon is at x=10, y=16
Sensor at x=14, y=17: closest beacon is at x=10, y=16
Sensor at x=8, y=7: closest beacon is at x=2, y=10
Sensor at x=2, y=0: closest beacon is at x=2, y=10
Sensor at x=0, y=11: closest beacon is at x=2, y=10
Sensor at x=20, y=14: closest beacon is at x=25, y=17
Sensor at x=17, y=20: closest beacon is at x=21, y=22
Sensor at x=16, y=7: closest beacon is at x=15, y=3
Sensor at x=14, y=3: closest beacon is at x=15, y=3
Sensor at x=20, y=1: closest beacon is at x=15, y=3''';

    group('part 1', () {
      test('example', () {
        expect(Day15().part1(exampleInput, 10), 26);
      });

      test('solution', () => Day15().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day15().part2(exampleInput, 20), 56000011);
      });

      test('solution', () => Day15().testPart2());
    });
  });
}
