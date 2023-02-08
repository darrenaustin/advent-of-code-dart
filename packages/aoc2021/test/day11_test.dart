import 'package:aoc2021/src/day11.dart';
import 'package:test/test.dart';

main() {
  group('2021 Day 11', () {
    final exampleInput = '''
5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526''';

    group('part 1', () {
      test('example', () {
        expect(Day11().part1(exampleInput), 1656);
      });

      test('solution', () => Day11().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day11().part2(exampleInput), 195);
      });


      test('solution', () => Day11().testPart2());
    });
  });
}
