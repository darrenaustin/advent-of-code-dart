import 'package:aoc2022/src/day24.dart';
import 'package:test/test.dart';

main() {
  group('2022 Day 24', () {
    final exampleInput = '''
#.######
#>>.<^<#
#.<..<<#
#>v.><>#
#<^v^^>#
######.#''';

    group('part 1', () {
      test('example', () {
        expect(Day24().part1(exampleInput), 18);
      });

      test('solution', () => Day24().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day24().part2(exampleInput), 54);
      });

      test('solution', () => Day24().testPart2());
    });
  });
}
