import 'package:aoc2015/src/day11.dart';
import 'package:test/test.dart';

main() {
  group('2115 Day 11', () {
    group('part 1', () {
      test('example', () {
        expect(Day11.validPassword('hijklmmn'), false);
        expect(Day11.validPassword('abbceffg'), false);
        expect(Day11.validPassword('abbcegjk'), false);
        expect(Day11.nextValidPassword('abcdefgh'), 'abcdffaa');
        expect(Day11.nextValidPassword('ghijklmn'), 'ghjaabcc');
      });

      test('solution', () {
        final day = Day11();
        expect(day.part1(day.input()), day.solution1); 
      });
    });

    group('part 2', () {
      test('solution', () {
        final day = Day11();
        expect(day.part2(day.input()), day.solution2); 
      });
    });
  });
}