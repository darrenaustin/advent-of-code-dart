import 'package:aoc2017/src/day02.dart';
import 'package:test/test.dart';

main() {
  group('2017 Day 02', () {
    group('part 1', () {
      test('example', () {
        final exampleInput = '''
5 1 9 5
7 5 3
2 4 6 8''';
        expect(Day02().part1(exampleInput), 18);
      });

      test('solution', () => Day02().testPart1());
    });

    group('part 2', () {
      test('example', () {
        final exampleInput = '''
5 9 2 8
9 4 7 3
3 8 6 5''';
        expect(Day02().part2(exampleInput), 9);
      });

      test('solution', () => Day02().testPart2());
    });
  });
}
