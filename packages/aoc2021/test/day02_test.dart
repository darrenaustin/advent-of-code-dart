import 'package:aoc2021/src/day02.dart';
import 'package:test/test.dart';

main() {
  group('2021 Day 02', () {
    final exampleInput = '''
forward 5
down 5
forward 8
up 3
down 8
forward 2''';
    group('part 1', () {
      test('example', () {
        expect(Day02().part1(exampleInput), 150);
      });

      test('solution', () => Day02().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day02().part2(exampleInput), 900);
      });

      test('solution', () => Day02().testPart2());
    });
  });
}
