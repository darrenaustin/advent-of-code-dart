import 'package:aoc2022/src/day08.dart';
import 'package:test/test.dart';

main() {
  group('2022 Day 08', () {
    final exampleInput = '''
30373
25512
65332
33549
35390''';

    group('part 1', () {
      test('example', () {
        expect(Day08().part1(exampleInput), 21);
      });

      test('solution', () => Day08().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day08().part2(exampleInput), 8);
      });

      test('solution', () => Day08().testPart2());
    });
  });
}
