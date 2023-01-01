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

      test('solution', () {
        final day = Day01();
        expect(day.part1(day.input()), day.solution1); 
      });
    });

    group('part 2', () {
      test('examples', () {
        expect(Day01().part2(')'), 1); 
        expect(Day01().part2('()())'), 5); 
      });

      test('solution', () {
        final day = Day01();
        expect(day.part2(day.input()), day.solution2); 
      });
    });
  });
}