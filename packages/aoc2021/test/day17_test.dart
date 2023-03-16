import 'package:aoc2021/src/day17.dart';
import 'package:test/test.dart';

main() {
  group('2021 Day 17', () {

    final exampleInput = 'target area: x=20..30, y=-10..-5';

    group('part 1', () {
      test('example', () {
        expect(Day17().part1(exampleInput), 45);
      });

      test('solution', () => Day17().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day17().part2(exampleInput), 112);
      });

      test('solution', () => Day17().testPart2());
    });
  });
}
