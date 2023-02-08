import 'package:aoc2021/src/day09.dart';
import 'package:test/test.dart';

main() {
  group('2021 Day 09', () {
    final exampleInput = '''
2199943210
3987894921
9856789892
8767896789
9899965678''';

    group('part 1', () {
      test('example', () {
        expect(Day09().part1(exampleInput), 15);
      });

      test('solution', () => Day09().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day09().part2(exampleInput), 1134);
      });

      test('solution', () => Day09().testPart2());
    });
  });
}
