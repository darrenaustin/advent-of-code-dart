import 'package:aoc2017/src/day05.dart';
import 'package:test/test.dart';

main() {
  group('2017 Day 05', () {
    final exampleInput = '''
0
3
0
1
-3''';

    group('part 1', () {
      test('example', () {
        expect(Day05().part1(exampleInput), 5);
      });

      test('solution', () => Day05().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day05().part2(exampleInput), 10);
      });

      test('solution', () => Day05().testPart2());
    });
  });
}
