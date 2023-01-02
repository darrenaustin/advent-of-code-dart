import 'package:aoc2015/src/day01.dart';
import 'package:test/test.dart';

main() {
  group('2015 Day 01', () {
    group('part 1', () {
      test('examples', () {
        expect(Day01().part1('(())'), 0); 
        expect(Day01().part1('()()'), 0); 
        expect(Day01().part1('((('), 3); 
        expect(Day01().part1('(()(()('), 3); 
        expect(Day01().part1('))((((('), 3); 
        expect(Day01().part1('())'), -1); 
        expect(Day01().part1('))('), -1); 
        expect(Day01().part1(')))'), -3); 
        expect(Day01().part1(')())())'), -3); 
      });

      test('solution', () => Day01().testPart1());
    });

    group('part 2', () {
      test('examples', () {
        expect(Day01().part2(')'), 1); 
        expect(Day01().part2('()())'), 5); 
      });

      test('solution', () => Day01().testPart2());
    });
  });
}