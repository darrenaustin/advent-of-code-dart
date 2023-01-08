import 'package:aoc2019/src/day12.dart';
import 'package:test/test.dart';

main() {
  group('2019 Day 12', () {
        final exampleInput1 = '''
<x=-1, y=0, z=2>
<x=2, y=-10, z=-7>
<x=4, y=-8, z=8>
<x=3, y=5, z=-1>''';
        final exampleInput2 = '''
<x=-8, y=-10, z=0>
<x=5, y=5, z=10>
<x=2, y=-7, z=3>
<x=9, y=-8, z=-3>''';

    group('part 1', () {
      test('examples', () {
        expect(Day12().part1(exampleInput1, 10), 179);
        expect(Day12().part1(exampleInput2, 100), 1940);
      });

      test('solution', () => Day12().testPart1());
    });

    group('part 2', () {
      test('examples', () {
        expect(Day12().part2(exampleInput1), 2772);
        expect(Day12().part2(exampleInput2), 4686774924);
      });

      test('solution', () => Day12().testPart2());
    });
  });
}
