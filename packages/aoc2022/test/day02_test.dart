import 'package:aoc2022/src/day02.dart';
import 'package:test/test.dart';

main() {
  group('2022 Day 02', () {
    final exampleInput = '''
A Y
B X
C Z''';
    group('part 1', () {
      test('example', () {
        expect(Day02().part1(exampleInput), 15);
      });

      test('solution', () => Day02().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day02().part2(exampleInput), 12);
      });

      test('solution', () => Day02().testPart2());
    });
  });
}
