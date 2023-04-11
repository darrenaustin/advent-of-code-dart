import 'package:aoc2020/src/day17.dart';
import 'package:test/test.dart';

main() {
  group('2020 Day 17', () {
    final exampleInput = '''
.#.
..#
###''';

    group('part 1', () {
      test('example', () {
        expect(Day17().part1(exampleInput), 112);
      });

      test('solution', () => Day17().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day17().part2(exampleInput), 848);
      });

      test('solution', () => Day17().testPart2());
    });
  });
}
