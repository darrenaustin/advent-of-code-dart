import 'package:aoc2016/src/day18.dart';
import 'package:test/test.dart';

main() {
  group('2016 Day 18', () {
    group('part 1', () {
      test('examples', () {
        expect(Day18().part1('..^^.', 3), 6);
        expect(Day18().part1('.^^.^.^^^^', 10), 38);
      });

      test('solution', () => Day18().testPart1());
    });

    group('part 2', () {
      // test('example', () {
      //   expect(Day18().part2(exampleInput), 0);
      // });

      test('solution', () => Day18().testPart2());
    });
  });
}
