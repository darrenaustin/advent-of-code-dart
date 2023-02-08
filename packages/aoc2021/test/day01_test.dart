import 'package:aoc2021/src/day01.dart';
import 'package:test/test.dart';

main() {
  group('2021 Day 01', () {
    final exampleInput = '''
199
200
208
210
200
207
240
269
260
263''';
    group('part 1', () {
      test('example', () {
        expect(Day01().part1(exampleInput), 7);
      });

      test('solution', () => Day01().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day01().part2(exampleInput), 5);
      });

      test('solution', () => Day01().testPart2());
    });
  });
}
