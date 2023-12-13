import 'package:aoc2023/src/day13.dart';
import 'package:test/test.dart';

main() {
  group('2023 Day 13', () {
    final exampleInput = '''
#.##..##.
..#.##.#.
##......#
##......#
..#.##.#.
..##..##.
#.#.##.#.

#...##..#
#....#..#
..##..###
#####.##.
#####.##.
..##..###
#....#..#''';

    group('part 1', () {
      test('example', () {
        expect(Day13().part1(exampleInput), 405);
      });

      test('solution', () => Day13().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day13().part2(exampleInput), 400);
      });

      test('solution', () => Day13().testPart2());
    });
  });
}
