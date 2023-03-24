import 'package:aoc2020/src/day09.dart';
import 'package:test/test.dart';

main() {
  group('2020 Day 09', () {
    final exampleInput = '''
35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576''';

    group('part 1', () {
      test('example', () {
        expect(Day09().part1(exampleInput, 5), 127);
      });

      test('solution', () => Day09().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day09().part2(exampleInput, 5), 62);
      });

      test('solution', () => Day09().testPart2());
    });
  });
}
