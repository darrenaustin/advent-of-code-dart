import 'package:aoc2020/src/day02.dart';
import 'package:test/test.dart';

main() {
  group('2020 Day 02', () {
    final exampleInput = '''
1-3 a: abcde
1-3 b: cdefg
2-9 c: ccccccccc''';

    group('part 1', () {
      test('example', () {
        expect(Day02().part1(exampleInput), 2);
      });

      test('solution', () => Day02().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day02().part2(exampleInput), 1);
      });

      test('solution', () => Day02().testPart2());
    });
  });
}
