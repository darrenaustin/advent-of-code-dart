import 'package:aoc2022/src/day12.dart';
import 'package:test/test.dart';

main() {
  group('2022 Day 12', () {
    final exampleInput = '''
Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi''';

    group('part 1', () {
      test('example', () {
        expect(Day12().part1(exampleInput), 31);
      });

      test('solution', () => Day12().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day12().part2(exampleInput), 29);
      });

      test('solution', () => Day12().testPart2());
    });
  });
}
