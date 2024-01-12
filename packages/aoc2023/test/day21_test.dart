import 'package:aoc2023/src/day21.dart';
import 'package:test/test.dart';

main() {
  group('2023 Day 21', () {
    final exampleInput = '''
...........
.....###.#.
.###.##..#.
..#.#...#..
....#.#....
.##..S####.
.##..#...#.
.......##..
.##.#.####.
.##..##.##.
...........''';

    group('part 1', () {
      test('example', () {
        expect(Day21().part1(exampleInput, 6), 16);
      });

      test('solution', () => Day21().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day21().part2(exampleInput, 6), 16);
        expect(Day21().part2(exampleInput, 10), 50);
        expect(Day21().part2(exampleInput, 50), 1594);
        expect(Day21().part2(exampleInput, 100), 6536);
        expect(Day21().part2(exampleInput, 500), 167004);
        expect(Day21().part2(exampleInput, 1000), 668697);

        // This is too expensive to evaluate with brute force,
        // and the quadratic trick for the main input doesn't
        // apply.
        // expect(Day21().part2(exampleInput, 5000), 16733044);
      });

      test('solution', () => Day21().testPart2());
    });
  });
}
