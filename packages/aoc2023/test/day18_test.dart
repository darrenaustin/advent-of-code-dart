import 'package:aoc2023/src/day18.dart';
import 'package:test/test.dart';

main() {
  group('2023 Day 18', () {
    final exampleInput = '''
R 6 (#70c710)
D 5 (#0dc571)
L 2 (#5713f0)
D 2 (#d2c081)
R 2 (#59c680)
D 2 (#411b91)
L 5 (#8ceee2)
U 2 (#caa173)
L 1 (#1b58a2)
U 2 (#caa171)
R 2 (#7807d2)
U 3 (#a77fa3)
L 2 (#015232)
U 2 (#7a21e3)''';

    group('part 1', () {
      test('example', () {
        expect(Day18().part1(exampleInput), 62);
      });

      test('solution', () => Day18().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day18().part2(exampleInput), 952408144115);
      });

      test('solution', () => Day18().testPart2());
    });
  });
}
