import 'package:aoc2015/src/day04.dart';
import 'package:test/test.dart';

main() {
  group('2015 Day 04', () {
    group('part 1', () {
      test('examples', () {
        expect(Day04().part1('abcdef'), 609043); 
        expect(Day04().part1('pqrstuv'), 1048970); 
      });

      test('solution', () {
        final day = Day04();
        expect(day.part1(day.input()), day.solution1); 
      });
    });

    group('part 2', () {
      test('solution', () {
        final day = Day04();
        expect(day.part2(day.input()), day.solution2); 
      });
    });
  });
}