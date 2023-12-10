import 'package:aoc2023/src/day10.dart';
import 'package:test/test.dart';

main() {
  group('2023 Day 10', () {
    final String exampleInput1 = '''
.....
.S-7.
.|.|.
.L-J.
.....''';

    final String exampleInput2 = '''
..F7.
.FJ|.
SJ.L7
|F--J
LJ...''';
    final String exampleInput3 = '''
...........
.S-------7.
.|F-----7|.
.||.....||.
.||.....||.
.|L-7.F-J|.
.|..|.|..|.
.L--J.L--J.
...........''';

    final String exampleInput4 = '''
..........
.S------7.
.|F----7|.
.||OOOO||.
.||OOOO||.
.|L-7F-J|.
.|II||II|.
.L--JL--J.
..........''';

    final String exampleInput5 = '''
.F----7F7F7F7F-7....
.|F--7||||||||FJ....
.||.FJ||||||||L7....
FJL7L7LJLJ||LJ.L-7..
L--J.L7...LJS7F-7L7.
....F-J..F7FJ|L7L7L7
....L7.F7||L7|.L7L7|
.....|FJLJ|FJ|F7|.LJ
....FJL-7.||.||||...
....L---J.LJ.LJLJ...''';

    final String exampleInput6 = '''
FF7FSF7F7F7F7F7F---7
L|LJ||||||||||||F--J
FL-7LJLJ||||||LJL-77
F--JF--7||LJLJ7F7FJ-
L---JF-JLJ.||-FJLJJ7
|F|F-JF---7F7-L7L|7|
|FFJF7L7F-JF7|JL---7
7-L-JL7||F7|L7F-7F7|
L.L7LFJ|||||FJL7||LJ
L7JLJL-JLJLJL--JLJ.L''';

    group('part 1', () {
      test('examples', () {
        expect(Day10().part1(exampleInput1), 4);
        expect(Day10().part1(exampleInput2), 8);
      });

      test('solution', () => Day10().testPart1());
    });

    group('part 2', () {
      test('examples', () {
        expect(Day10().part2(exampleInput3), 4);
        expect(Day10().part2(exampleInput4), 4);
        expect(Day10().part2(exampleInput5), 8);
        expect(Day10().part2(exampleInput6), 10);
      });

      test('solution', () => Day10().testPart2());
    });
  });
}
