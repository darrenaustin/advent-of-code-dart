import 'package:aoc2015/src/day05.dart';
import 'package:test/test.dart';

main() {
  group('2015 Day 05', () {
    group('part 1', () {
      test('examples', () {
        expect(Day05.niceStringPart1('ugknbfddgicrmopn'), true); 
        expect(Day05.niceStringPart1('aaa'), true); 
        expect(Day05.niceStringPart1('jchzalrnumimnmhp'), false); 
        expect(Day05.niceStringPart1('haegwjzuvuyypxyu'), false); 
        expect(Day05.niceStringPart1('dvszwmarrgswjxmb'), false); 
      });

      test('solution', () {
        final day = Day05();
        expect(day.part1(day.input()), day.solution1); 
      });
    });

    group('part 2', () {
      test('examples', () {
        expect(Day05.niceStringPart2('qjhvhtzxzqqjkmpb'), true); 
        expect(Day05.niceStringPart2('xxyxx'), true); 
        expect(Day05.niceStringPart2('uurcxstgmygtbstg'), false); 
        expect(Day05.niceStringPart2('ieodomkazucvgmuy'), false); 
      });

      test('solution', () {
        final day = Day05();
        expect(day.part2(day.input()), day.solution2); 
      });
    });
  });
}