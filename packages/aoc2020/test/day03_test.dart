import 'package:aoc2020/src/day03.dart';
import 'package:test/test.dart';

main() {
  group('2020 Day 03', () {
    final exampleInput = '''
..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#''';

    group('part 1', () {
      test('example', () {
        expect(Day03().part1(exampleInput), 7);
      });

      test('solution', () => Day03().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day03().part2(exampleInput), 336);
      });

      test('solution', () => Day03().testPart2());
    });
  });
}
