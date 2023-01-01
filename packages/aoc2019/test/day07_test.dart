import 'package:aoc2019/src/day07.dart';
import 'package:test/test.dart';

main() {
  group('2019 Day 07', () {
    group('part 1', () {
      test('examples', () {
        // expect(Day07().part1(''), 0); 
      });

      test('solution', () {
        final day = Day07();
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
        // expect(Day07().part2(')'), 1); 
      });

      test('solution', () {
        final day = Day07();
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
