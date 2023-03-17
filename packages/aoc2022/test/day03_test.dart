import 'package:aoc2022/src/day03.dart';
import 'package:test/test.dart';

main() {
  group('2022 Day 03', () {
    final exampleInput = '''
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw''';

    group('part 1', () {
      test('example', () {
        expect(Day03().part1(exampleInput), 157);
      });

      test('solution', () => Day03().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day03().part2(exampleInput), 70);
      });

      test('solution', () => Day03().testPart2());
    });
  });
}
