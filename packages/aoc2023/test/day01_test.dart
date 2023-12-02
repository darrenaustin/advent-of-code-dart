import 'package:aoc2023/src/day01.dart';
import 'package:test/test.dart';

main() {
  group('2023 Day 01', () {
    group('part 1', () {
      final String exampleInput = '''
1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet''';
      test('example', () {
        expect(Day01().part1(exampleInput), 142);
      });

      test('solution', () => Day01().testPart1());
    });

    group('part 2', () {
      final String exampleInput = '''
two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen''';
      test('example', () {
        expect(Day01().part2(exampleInput), 281);
      });

      test('solution', () => Day01().testPart2());
    });
  });
}
