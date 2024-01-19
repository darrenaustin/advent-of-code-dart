import 'package:aoc2017/src/day11.dart';
import 'package:test/test.dart';

main() {
  group('2017 Day 11', () {
    group('part 1', () {
      test('example', () {
        expect(Day11().part1('ne,ne,ne'), 3);
        expect(Day11().part1('ne,ne,sw,sw'), 0);
        expect(Day11().part1('ne,ne,s,s'), 2);
        expect(Day11().part1('se,sw,se,sw,sw'), 3);
      });

      test('solution', () => Day11().testPart1());
    });

    group('part 2', () {
      test('solution', () => Day11().testPart2());
    });
  });
}
