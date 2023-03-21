import 'package:aoc2022/src/day11.dart';
import 'package:test/test.dart';

main() {
  group('2022 Day 11', () {
    final exampleInput = '''
Monkey 0:
  Starting items: 79, 98
  Operation: new = old * 19
  Test: divisible by 23
    If true: throw to monkey 2
    If false: throw to monkey 3

Monkey 1:
  Starting items: 54, 65, 75, 74
  Operation: new = old + 6
  Test: divisible by 19
    If true: throw to monkey 2
    If false: throw to monkey 0

Monkey 2:
  Starting items: 79, 60, 97
  Operation: new = old * old
  Test: divisible by 13
    If true: throw to monkey 1
    If false: throw to monkey 3

Monkey 3:
  Starting items: 74
  Operation: new = old + 3
  Test: divisible by 17
    If true: throw to monkey 0
    If false: throw to monkey 1''';

    group('part 1', () {
      test('examples', () {
        expect(Day11().part1(exampleInput), 10605);
      });

      test('solution', () => Day11().testPart1());
    });

    group('part 2', () {
      test('examples', () {
        expect(Day11().part2(exampleInput), 2713310158);
      });

      test('solution', () => Day11().testPart2());
    });
  });
}
