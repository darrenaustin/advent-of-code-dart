import 'package:aoc2017/src/day01.dart';
import 'package:test/test.dart';

main() {
  group('2017 Day 01', () {
    group('part 1', () {
      test('examples', () {
        expect(Day01().part1('1122'), 3); 
        expect(Day01().part1('1111'), 4); 
        expect(Day01().part1('1234'), 0); 
        expect(Day01().part1('91212129'), 9); 
      });

      test('solution', () => Day01().testPart1());
    });

    group('part 2', () {
      test('examples', () {
        expect(Day01().part2('1212'), 6); 
        expect(Day01().part2('1221'), 0); 
        expect(Day01().part2('123425'), 4); 
        expect(Day01().part2('123123'), 12); 
        expect(Day01().part2('12131415'), 4); 
      });

      test('solution', () => Day01().testPart2());
    });
  });
}
