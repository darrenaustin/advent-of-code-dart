import 'package:aoc2021/src/day05.dart';
import 'package:test/test.dart';

main() {
  group('2021 Day 05', () {
    final exampleInput = '''
0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2''';
    group('part 1', () {
      test('example', () {
        expect(Day05().part1(exampleInput), 5);
      });

      test('solution', () => Day05().testPart1());
    });

    group('part 2', () {
      test('examples', () {
        expect(Day05().part2(exampleInput), 12);
      });

      test('solution', () => Day05().testPart2());
    });
  });
}
