import 'package:aoc/util/range.dart';
import 'package:aoc2023/src/day24.dart';
import 'package:test/test.dart';

main() {
  group('2023 Day 24', () {
    final exampleInput = '''
19, 13, 30 @ -2,  1, -2
18, 19, 22 @ -1, -1, -2
20, 25, 34 @ -2, -2, -4
12, 31, 28 @ -1, -2, -1
20, 19, 15 @  1, -5, -3''';

    group('part 1', () {
      test('example', () {
        expect(Day24().part1(exampleInput, Range(7, 28)), 2);
      });

      test('solution', () => Day24().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day24().part2(exampleInput), 47);
      });

      test('solution', () => Day24().testPart2());
    });
  });
}
