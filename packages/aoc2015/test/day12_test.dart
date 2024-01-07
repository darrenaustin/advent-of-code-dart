import 'package:aoc2015/src/day12.dart';
import 'package:test/test.dart';

main() {
  group('2015 Day 12', () {
    group('part 1', () {
      test('examples', () {
        expect(Day12().part1('[1,2,3]'), 6);
        expect(Day12().part1('{"a":2,"b":4}'), 6);
        expect(Day12().part1('[[[3]]]'), 3);
        expect(Day12().part1('{"a":{"b":4},"c":-1}'), 3);
        expect(Day12().part1('{"a":[-1,1]}'), 0);
        expect(Day12().part1('[-1,{"a":1}]'), 0);
        expect(Day12().part1('[]'), 0);
        expect(Day12().part1('{}}'), 0);
      });

      test('solution', () => Day12().testPart1());
    });

    group('part 2', () {
      test('examples', () {
        expect(Day12().part2('[1,2,3]'), 6);
        expect(Day12().part2('[1,{"c":"red","b":2},3]'), 4);
        expect(Day12().part2('[1,"red",5]'), 6);
      });

      test('solution', () => Day12().testPart2());
    });
  });
}
