import 'package:aoc2022/src/day17.dart';
import 'package:test/test.dart';

main() {
  group('2022 Day 17', () {
    final exampleInput = '>>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>';

    group('part 1', () {
      test('example', () {
        expect(Day17().part1(exampleInput), 3068);
      });

      test('solution', () => Day17().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day17().part2(exampleInput), 1514285714288);
      });

      test('solution', () => Day17().testPart2());
    });
  });
}
