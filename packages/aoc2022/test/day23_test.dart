import 'package:aoc2022/src/day23.dart';
import 'package:test/test.dart';

main() {
  group('2022 Day 23', () {
    final exampleInput = '''
....#..
..###.#
#...#.#
.#...##
#.###..
##.#.##
.#..#..''';

    group('part 1', () {
      test('example', () {
        expect(Day23().part1(exampleInput), 110);
      });

      test('solution', () => Day23().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day23().part2(exampleInput), 20);
      });

      test('solution', () => Day23().testPart2());
    });
  });
}
