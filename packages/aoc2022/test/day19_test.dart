import 'package:aoc2022/src/day19.dart';
import 'package:test/test.dart';

main() {
  group('2022 Day 19', () {
    final exampleInput = '''
Blueprint 1: Each ore robot costs 4 ore. Each clay robot costs 2 ore. Each obsidian robot costs 3 ore and 14 clay. Each geode robot costs 2 ore and 7 obsidian.
Blueprint 2: Each ore robot costs 2 ore. Each clay robot costs 3 ore. Each obsidian robot costs 3 ore and 8 clay. Each geode robot costs 3 ore and 12 obsidian.''';
    group('part 1', () {
      test('example', () {
        expect(Day19().part1(exampleInput), 33);
      });

      test('solution', () => Day19().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day19().part2(exampleInput), 56 * 62);
      });

      test('solution', () => Day19().testPart2());
    });
  });
}
