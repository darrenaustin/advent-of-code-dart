import 'package:aoc2016/src/day20.dart';
import 'package:test/test.dart';

main() {
  group('2016 Day 20', () {
    final exampleInput = '''
5-8
0-2
4-7''';

    group('part 1', () {
      test('example', () {
        expect(Day20().part1(exampleInput), 3);
      });

      test('solution', () => Day20().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day20().part2(exampleInput, 9), 2);
      });

      test('solution', () => Day20().testPart2());
    });
  });
}
