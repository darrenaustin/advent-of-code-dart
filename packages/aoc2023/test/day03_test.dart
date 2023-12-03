import 'package:aoc2023/src/day03.dart';
import 'package:test/test.dart';

main() {
  group('2023 Day 03', () {
    final String exampleInput = r'''
467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..''';

    group('part 1', () {
      test('example', () {
        expect(Day03().part1(exampleInput), 4361);
      });

      test('solution', () => Day03().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day03().part2(exampleInput), 467835);
      });

      test('solution', () => Day03().testPart2());
    });
  });
}
