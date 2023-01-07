import 'package:aoc2016/src/day01.dart';
import 'package:test/test.dart';

main() {
  group('2016 Day 01', () {
    group('part 1', () {
      test('examples', () {
        expect(Day01().part1('R2, L3'), 5); 
        expect(Day01().part1('R2, R2, R2'), 2); 
        expect(Day01().part1('R5, L5, R5, R3'), 12); 
      });

      test('solution', () => Day01().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day01().part2('R8, R4, R4, R8'), 4); 
      });

      test('solution', () => Day01().testPart2());
    });
  });
}
