import 'package:aoc2016/src/day09.dart';
import 'package:test/test.dart';

main() {
  group('2016 Day 09', () {
    group('part 1', () {
      test('examples', () {
        expect(Day09().part1('ADVENT'), 6); 
        expect(Day09().part1('A(1x5)BC'), 7); 
        expect(Day09().part1('(3x3)XYZ'), 9); 
        expect(Day09().part1('A(2x2)BCD(2x2)EFG'), 11); 
        expect(Day09().part1('(6x1)(1x3)A'), 6);
        expect(Day09().part1('X(8x2)(3x3)ABCY'), 18);
      });

      test('solution', () => Day09().testPart1());
    });

    group('part 2', () {
      test('examples', () {
        expect(Day09().part2('(3x3)XYZ'), 'XYZXYZXYZ'.length); 
        expect(Day09().part2('X(8x2)(3x3)ABCY'), 'XABCABCABCABCABCABCY'.length); 
        expect(Day09().part2('(27x12)(20x12)(13x14)(7x10)(1x12)A'), 241920); 
        expect(Day09().part2('(25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN'), 445); 
      });

      test('solution', () => Day09().testPart2());
    });
  });
}
