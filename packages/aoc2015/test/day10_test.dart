import 'package:aoc2015/src/day10.dart';
import 'package:test/test.dart';

main() {
  group('2105 Day 10', () {
    group('part 1', () {
      test('example', () {
        expect(Day10.say('1'), '11');
        expect(Day10.say('11'), '21');
        expect(Day10.say('21'), '1211');
        expect(Day10.say('1211'), '111221');
        expect(Day10.say('111221'), '312211');
      });

      test('solution', () {
        final day = Day10();
        expect(day.part1(day.input()), day.solution1); 
      });
    });

    group('part 2', () {
      test('solution', () {
        final day = Day10();
        expect(day.part2(day.input()), day.solution2); 
      });
    });
  });
}