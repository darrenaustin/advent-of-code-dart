import 'package:aoc2023/src/day09.dart';
import 'package:test/test.dart';

main() {
  group('2023 Day 09', () {
    final String exampleInput = '''
0 3 6 9 12 15
1 3 6 10 15 21
10 13 16 21 30 45''';

    group('part 1', () {
      test('example', () {
        expect(Day09().part1(exampleInput), 114);
      });

      test('solution', () => Day09().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day09().part2(exampleInput), 2);
      });

      test('solution', () => Day09().testPart2());
    });
  });
}
