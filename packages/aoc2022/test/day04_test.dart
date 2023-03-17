import 'package:aoc2022/src/day04.dart';
import 'package:test/test.dart';

main() {
  final exampleInput = '''
2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8''';

  group('2022 Day 04', () {
    group('part 1', () {
      test('example', () {
        expect(Day04().part1(exampleInput), 2);
      });

      test('solution', () => Day04().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day04().part2(exampleInput), 4);
      });

      test('solution', () => Day04().testPart2());
    });
  });
}
