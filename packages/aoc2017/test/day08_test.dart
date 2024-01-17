import 'package:aoc2017/src/day08.dart';
import 'package:test/test.dart';

main() {
  group('2017 Day 08', () {
    final exampleInput = '''
b inc 5 if a > 1
a inc 1 if b < 5
c dec -10 if a >= 1
c inc -20 if c == 10''';

    group('part 1', () {
      test('example', () {
        expect(Day08().part1(exampleInput), 1);
      });

      test('solution', () => Day08().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day08().part2(exampleInput), 10);
      });

      test('solution', () => Day08().testPart2());
    });
  });
}
