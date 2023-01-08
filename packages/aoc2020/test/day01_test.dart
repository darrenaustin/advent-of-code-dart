import 'package:aoc2020/src/day01.dart';
import 'package:test/test.dart';

main() {
  group('2020 Day 01', () {
    final exampleInput = '''
1721
979
366
299
675
1456''';
    group('part 1', () {
      test('example', () {
        expect(Day01().part1(exampleInput), 514579);
      });

      test('solution', () => Day01().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day01().part2(exampleInput), 241861950);
      });

      test('solution', () => Day01().testPart2());
    });
  });
}
