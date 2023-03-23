import 'package:aoc2020/src/day06.dart';
import 'package:test/test.dart';

main() {
  group('2020 Day 06', () {
    final exampleInput = '''
abc

a
b
c

ab
ac

a
a
a
a

b''';

    group('part 1', () {
      test('example', () {
        expect(Day06().part1(exampleInput), 11);
      });

      test('solution', () => Day06().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day06().part2(exampleInput), 6);
      });

      test('solution', () => Day06().testPart2());
    });
  });
}
