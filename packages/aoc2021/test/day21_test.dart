import 'package:aoc2021/src/day21.dart';
import 'package:test/test.dart';

main() {
  group('2021 Day 21', () {
    final exampleInput = '''
Player 1 starting position: 4
Player 2 starting position: 8
''';

    group('part 1', () {
      test('example', () {
        expect(Day21().part1(exampleInput), 739785);
      });

      test('solution', () => Day21().testPart1());
    });

    group('part 2', () {
      // test('example', () {
      //   expect(Day21().part2(exampleInput), 444356092776315);
      // });

      test('solution', () => Day21().testPart2());
    });
  });
}
