import 'package:aoc2016/src/day11.dart';
import 'package:test/test.dart';

main() {
  group('2016 Day 11', () {
    final exampleInput = '''
The first floor contains a hydrogen-compatible microchip and a lithium-compatible microchip.
The second floor contains a hydrogen generator.
The third floor contains a lithium generator.
The fourth floor contains nothing relevant.''';

    group('part 1', () {
      test('example', () {
        expect(Day11().part1(exampleInput), 11);
      });

      test('solution', () => Day11().testPart1());
    });

    group('part 2', () {
      test('solution', () => Day11().testPart2());
    });
  });
}
