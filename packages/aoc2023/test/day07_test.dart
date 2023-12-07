import 'package:aoc2023/src/day07.dart';
import 'package:test/test.dart';

main() {
  group('2023 Day 07', () {
    final String exampleInput = '''
32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483''';

    group('part 1', () {
      test('example', () {
        expect(Day07().part1(exampleInput), 6440);
      });

      test('solution', () => Day07().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day07().part2(exampleInput), 5905);
      });

      test('solution', () => Day07().testPart2());
    });
  });
}
