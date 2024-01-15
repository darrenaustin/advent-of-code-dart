import 'package:aoc2016/src/day24.dart';
import 'package:test/test.dart';

main() {
  group('2016 Day 24', () {
    final String exampleInput = '''
###########
#0.1.....2#
#.#######.#
#4.......3#
###########''';

    group('part 1', () {
      test('example', () {
        expect(Day24().part1(exampleInput), 14);
      });

      test('solution', () => Day24().testPart1());
    });

    group('part 2', () {
      test('solution', () => Day24().testPart2());
    });
  });
}
