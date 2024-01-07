import 'package:aoc2015/src/day19.dart';
import 'package:test/test.dart';

main() {
  group('2015 Day 19', () {
    group('part 1', () {
      test('examples', () {
        final String exampleInput = '''
H => HO
H => OH
O => HH''';
        expect(Day19().part1(exampleInput), 4);
      });

      test('solution', () => Day19().testPart1());
    });

    group('part 2', () {
      test('examples', () {
        final String exampleInput = '''
e => H
e => O
H => HO
H => OH
O => HH''';
        expect(
            Day19().part2(
              exampleInput,
              'HOH',
            ),
            3);
        expect(Day19().part2(exampleInput, 'HOHOHO'), 6);
      });

      test('solution', () => Day19().testPart2());
    });
  });
}
