import 'package:aoc2019/src/day10.dart';
import 'package:test/test.dart';

main() {
  group('2019 Day 10', () {
    final largeExample = '''
.#..##.###...#######
##.############..##.
.#.######.########.#
.###.#######.####.#.
#####.##.#.##.###.##
..#####..#.#########
####################
#.####....###.#.#.##
##.#################
#####.##.###..####..
..######..##.#######
####.##.####...##..#
.#####..#.######.###
##...#.##########...
#.##########.#######
.####.#.###.###.#.##
....##.##.###..#####
.#.#.###########.###
#.#.#.#####.####.###
###.##.####.##.#..##''';

    group('part 1', () {
      final exampleInput1 = '''
.#..#
.....
#####
....#
...##''';
      final exampleInput2 = '''
......#.#.
#..#.#....
..#######.
.#.#.###..
.#..#.....
..#....#.#
#..#....#.
.##.#..###
##...#..#.
.#....####''';
      final exampleInput3 = '''
#.#...#.#.
.###....#.
.#....#...
##.#.#.#.#
....#.#.#.
.##..###.#
..#...##..
..##....##
......#...
.####.###.''';
      final exampleInput4 = '''
.#..#..###
####.###.#
....###.#.
..###.##.#
##.##.#.#.
....###..#
..#.#..#.#
#..#.#.###
.##...##.#
.....#.#..''';

      test('examples', () {
        expect(Day10().part1(exampleInput1), 8);
        expect(Day10().part1(exampleInput2), 33);
        expect(Day10().part1(exampleInput3), 35);
        expect(Day10().part1(exampleInput4), 41);
        expect(Day10().part1(largeExample), 210);
      });

      test('solution', () => Day10().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day10().part2(largeExample), 802);
      });

      test('solution', () => Day10().testPart2());
    });
  });
}
