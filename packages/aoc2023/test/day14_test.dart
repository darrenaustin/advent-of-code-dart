import 'package:aoc2023/src/day14.dart';
import 'package:test/test.dart';

main() {
  group('2023 Day 14', () {
    final exampleInput = '''
O....#....
O.OO#....#
.....##...
OO.#O....O
.O.....O#.
O.#..O.#.#
..O..#O..O
.......O..
#....###..
#OO..#....''';

    group('part 1', () {
      test('example', () {
        expect(Day14().part1(exampleInput), 136);
      });

      test('solution', () => Day14().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day14().part2(exampleInput), 64);
      });

      test('solution', () => Day14().testPart2());
    });
  });
}
