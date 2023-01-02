import 'package:aoc2015/src/day18.dart';
import 'package:test/test.dart';

main() {
  group('2015 Day 18', () {
    final exampleInput = '''
.#.#.#
...##.
#....#
..#...
#.#..#
####..''';

    group('part 1', () {
      test('example', () {
        expect(Day18().part1(exampleInput, 4), 4);
      });

      test('solution', () => Day18().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day18().part2(exampleInput, 5), 17);
      });

      test('solution', () => Day18().testPart2());
    });
  });
}
