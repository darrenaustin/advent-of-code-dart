import 'package:aoc2022/src/day09.dart';
import 'package:test/test.dart';

main() {
  group('2022 Day 09', () {
    group('part 1', () {
      test('example', () {
          final exampleInput = '''
R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2''';
        expect(Day09().part1(exampleInput), 13);
      });

      test('solution', () => Day09().testPart1());
    });

    group('part 2', () {
      test('example', () {
          final exampleInput = '''
R 5
U 8
L 8
D 3
R 17
D 10
L 25
U 20''';

        expect(Day09().part2(exampleInput), 36);
      });

      test('solution', () => Day09().testPart2());
    });
  });
}
