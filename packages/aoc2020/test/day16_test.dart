import 'package:aoc2020/src/day16.dart';
import 'package:test/test.dart';

main() {
  group('2020 Day 16', () {
    final exampleInput = '''
class: 1-3 or 5-7
row: 6-11 or 33-44
seat: 13-40 or 45-50

your ticket:
7,1,14

nearby tickets:
7,3,47
40,4,50
55,2,20
38,6,12''';

    group('part 1', () {
      test('example', () {
        expect(Day16().part1(exampleInput), 71);
      });

      test('solution', () => Day16().testPart1());
    });

    group('part 2', () {
      test('solution', () => Day16().testPart2());
    });
  });
}
