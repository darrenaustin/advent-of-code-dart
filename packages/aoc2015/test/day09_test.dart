import 'package:aoc2015/src/day09.dart';
import 'package:test/test.dart';

main() {
  group('2015 Day 09', () {
    final exampleRoutes = '''
London to Dublin = 464
London to Belfast = 518
Dublin to Belfast = 141''';

    group('part 1', () {

      test('example', () {
        expect(Day09().part1(exampleRoutes), 605);
      });

      test('solution', () => Day09().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day09().part2(exampleRoutes), 982);
      });

      test('solution', () => Day09().testPart2());
    });
  });
}