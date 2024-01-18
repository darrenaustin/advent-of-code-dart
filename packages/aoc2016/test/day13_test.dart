import 'package:aoc/util/vec.dart';
import 'package:aoc2016/src/day13.dart';
import 'package:test/test.dart';

main() {
  group('2016 Day 13', () {
    group('part 1', () {
      test('example', () {
        expect(Day13().part1('10', Vec(7, 4)), 11);
      });

      test('solution', () => Day13().testPart1());
    });

    group('part 2', () {
      test('solution', () => Day13().testPart2());
    });
  });
}
