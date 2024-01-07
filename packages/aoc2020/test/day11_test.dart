import 'package:aoc2020/src/day11.dart';
import 'package:test/test.dart';

main() {
  group('2020 Day 11', () {
    final exampleInput = '''
L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL''';

    group('part 1', () {
      test('example', () {
        expect(Day11().part1(exampleInput), 37);
      });

      test('solution', () => Day11().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day11().part2(exampleInput), 26);
      });

      test('solution', () => Day11().testPart2());
    });
  });
}
