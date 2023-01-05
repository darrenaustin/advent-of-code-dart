import 'package:aoc2015/src/day24.dart';
import 'package:test/test.dart';

main() {
  group('2015 Day 24', () {
    group('part 1', () {
    test('example', () {
        final exampleInput = '''
1
2
3
4
5
7
8
9
10
11''';
        expect(Day24().part1(exampleInput), 99);
      });

      test('solution', () => Day24().testPart1());
    });

    group('part 2', () {
      // test('examples', () {
      //   expect(Day24().part2(''), 0); 
      // });

      test('solution', () => Day24().testPart2());
    });
  });
}
