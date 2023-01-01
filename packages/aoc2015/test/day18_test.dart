import 'package:aoc2015/src/day18.dart';
import 'package:test/test.dart';

main() {
  group('2015 Day 18', () {
    group('part 1', () {
      test('examples', () {
        // expect(Day18().part1(''), 0); 
      });

      test('solution', () {
        final day = Day18();
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
        // expect(Day18().part2(')'), 1); 
      });

      test('solution', () {
        final day = Day18();
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
