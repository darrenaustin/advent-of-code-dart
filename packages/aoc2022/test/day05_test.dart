import 'package:aoc2022/src/day05.dart';
import 'package:test/test.dart';

main() {
  final exampleInput = '''
    [D]
[N] [C]
[Z] [M] [P]
 1   2   3

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2''';

  group('2022 Day 05', () {
    group('part 1', () {
      test('example', () {
        expect(Day05().part1(exampleInput), 'CMZ');
      });

      test('solution', () => Day05().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day05().part2(exampleInput), 'MCD');
      });

      test('solution', () => Day05().testPart2());
    });
  });
}
