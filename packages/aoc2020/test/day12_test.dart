import 'package:aoc2020/src/day12.dart';
import 'package:test/test.dart';

main() {
  group('2020 Day 12', () {
    final exampleInput = '''
F10
N3
F7
R90
F11''';

    group('part 1', () {
      test('example', () {
        expect(Day12().part1(exampleInput), 25);
      });

      test('solution', () => Day12().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day12().part2(exampleInput), 286);
      });

      test('solution', () => Day12().testPart2());
    });
  });
}
