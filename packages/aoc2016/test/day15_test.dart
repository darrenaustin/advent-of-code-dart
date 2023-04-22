import 'package:aoc2016/src/day15.dart';
import 'package:test/test.dart';

main() {
  group('2016 Day 15', () {
    final exampleInput = '''
Disc #1 has 5 positions; at time=0, it is at position 4.
Disc #2 has 2 positions; at time=0, it is at position 1.''';

    group('part 1', () {
      test('example', () {
        expect(Day15().part1(exampleInput), 5);
      });

      test('solution', () => Day15().testPart1());
    });

    group('part 2', () {
      test('solution', () => Day15().testPart2());
    });
  });
}
