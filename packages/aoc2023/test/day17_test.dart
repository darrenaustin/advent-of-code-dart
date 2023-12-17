import 'package:aoc2023/src/day17.dart';
import 'package:test/test.dart';

main() {
  group('2023 Day 17', () {
    final exampleInput1 = '''
2413432311323
3215453535623
3255245654254
3446585845452
4546657867536
1438598798454
4457876987766
3637877979653
4654967986887
4564679986453
1224686865563
2546548887735
4322674655533''';
    final exampleInput2 = '''
111111111111
999999999991
999999999991
999999999991
999999999991''';

    group('part 1', () {
      test('example', () {
        expect(Day17().part1(exampleInput1), 102);
      });

      test('solution', () => Day17().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day17().part2(exampleInput1), 94);
        expect(Day17().part2(exampleInput2), 71);
      });

      test('solution', () => Day17().testPart2());
    });
  });
}
