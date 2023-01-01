import 'package:aoc2016/src/day04.dart';
import 'package:test/test.dart';

main() {
  group('2016 Day 04', () {
    group('part 1', () {
      test('examples', () {
        // expect(Day04().part1(''), 0); 
      });

      test('solution', () {
        final day = Day04();
        final result = day.part1(day.input());
        if (day.solution1 == null) {
          print('Unknown solution $result');
        } else {
          expect(result, day.solution1); 
        }
      });
    });

    group('part 2', () {
      test('examples', () {
        // expect(Day04().part2(')'), 1); 
      });

      test('solution', () {
        final day = Day04();
        final result = day.part2(day.input());
        if (day.solution2 == null) {
          print('Unknown solution $result');
        } else {
          expect(result, day.solution2); 
        }
      });
    });
  });
}
