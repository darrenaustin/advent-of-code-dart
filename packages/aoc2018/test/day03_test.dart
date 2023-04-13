import 'package:aoc2018/src/day03.dart';
import 'package:test/test.dart';

main() {
  group('2018 Day 03', () {
    final exampleInput = '''
#1 @ 1,3: 4x4
#2 @ 3,1: 4x4
#3 @ 5,5: 2x2''';

    group('part 1', () {
      test('example', () {
        expect(Day03().part1(exampleInput), 4);
      });

      test('solution', () => Day03().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day03().part2(exampleInput), 3);
      });

      test('solution', () => Day03().testPart2());
    });
  });
}
