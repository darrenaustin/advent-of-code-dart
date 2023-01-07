import 'package:aoc2016/src/day02.dart';
import 'package:test/test.dart';

main() {
  group('2016 Day 02', () {
    final exampleInput = '''
ULL
RRDDD
LURDL
UUUUD''';

    group('part 1', () {
      test('example', () {
        expect(Day02().part1(exampleInput), '1985'); 
      });

      test('solution', () => Day02().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day02().part2(exampleInput), '5DB3');
      });

      test('solution', () => Day02().testPart2());
    });
  });
}
