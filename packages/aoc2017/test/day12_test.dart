import 'package:aoc2017/src/day12.dart';
import 'package:test/test.dart';

main() {
  group('2017 Day 12', () {
    final exampleInput = '''
0 <-> 2
1 <-> 1
2 <-> 0, 3, 4
3 <-> 2, 4
4 <-> 2, 3, 6
5 <-> 6
6 <-> 4, 5''';

    group('part 1', () {
      test('example', () {
        expect(Day12().part1(exampleInput), 6);
      });

      test('solution', () => Day12().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day12().part2(exampleInput), 2);
      });

      test('solution', () => Day12().testPart2());
    });
  });
}
