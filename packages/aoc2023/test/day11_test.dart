import 'package:aoc2023/src/day11.dart';
import 'package:test/test.dart';

main() {
  group('2023 Day 11', () {
    final String exampleInput = '''
...#......
.......#..
#.........
..........
......#...
.#........
.........#
..........
.......#..
#...#.....''';

    group('part 1', () {
      test('example', () {
        expect(Day11().part1(exampleInput), 374);
      });

      test('solution', () => Day11().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day11().part2(exampleInput, 2), 374);
        expect(Day11().part2(exampleInput, 10), 1030);
        expect(Day11().part2(exampleInput, 100), 8410);
      });

      test('solution', () => Day11().testPart2());
    });
  });
}
