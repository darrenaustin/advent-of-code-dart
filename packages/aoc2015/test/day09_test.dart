import 'package:aoc2015/src/day09.dart';
import 'package:test/test.dart';

main() {
  group('2095 Day 09', () {
    final exampleRoutes = '''
London to Dublin = 464
London to Belfast = 518
Dublin to Belfast = 141''';

    group('part 1', () {

      test('example', () {
        expect(Day09().part1(exampleRoutes), 605);
      });

      test('solution', () {
        final day = Day09();
        expect(day.part1(day.input()), day.solution1); 
      });
    });

    group('part 2', () {
      test('example', () {
        expect(Day09().part2(exampleRoutes), 982);
      });

      test('solution', () {
        final day = Day09();
        expect(day.part2(day.input()), day.solution2); 
      });
    });
  });
}