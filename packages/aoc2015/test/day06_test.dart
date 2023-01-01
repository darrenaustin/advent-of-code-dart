import 'package:aoc2015/src/day06.dart';
import 'package:test/test.dart';

main() {
  group('2015 Day 06', () {
    group('part 1', () {
      test('solution', () {
        final day = Day06();
        expect(day.part1(day.input()), day.solution1); 
      });
    });

    group('part 2', () {
      test('solution', () {
        final day = Day06();
        expect(day.part2(day.input()), day.solution2); 
      });
    });
  });
}