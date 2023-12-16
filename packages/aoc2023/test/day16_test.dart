import 'package:aoc2023/src/day16.dart';
import 'package:test/test.dart';

main() {
  group('2023 Day 16', () {
    final exampleInput = r'''
.|...\....
|.-.\.....
.....|-...
........|.
..........
.........\
..../.\\..
.-.-/..|..
.|....-|.\
..//.|....''';

    group('part 1', () {
      test('example', () {
        expect(Day16().part1(exampleInput), 46);
      });

      test('solution', () => Day16().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day16().part2(exampleInput), 51);
      });

      test('solution', () => Day16().testPart2());
    });
  });
}
