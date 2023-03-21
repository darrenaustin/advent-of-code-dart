import 'package:aoc2022/src/day20.dart';
import 'package:test/test.dart';

main() {
  group('2022 Day 20', () {
    final exampleInput = '''
1
2
-3
3
-2
0
4''';

    group('part 1', () {
      test('example', () {
        expect(Day20().part1(exampleInput), 3);
      });

      test('solution', () => Day20().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day20().part2(exampleInput), 1623178306);
      });

      test('solution', () => Day20().testPart2());
    });
  });
}
