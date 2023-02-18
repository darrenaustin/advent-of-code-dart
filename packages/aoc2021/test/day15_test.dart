import 'package:aoc2021/src/day15.dart';
import 'package:test/test.dart';

main() {
  group('2021 Day 15', () {
    final exampleInput = '''
1163751742
1381373672
2136511328
3694931569
7463417111
1319128137
1359912421
3125421639
1293138521
2311944581''';

    group('part 1', () {
      test('example', () {
        expect(Day15().part1(exampleInput), 40);
      });

      test('solution', () => Day15().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day15().part2(exampleInput), 315);
      });

      test('solution', () => Day15().testPart2());
    });
  });
}
