import 'package:advent_of_code_dart/day.dart';
import 'package:test/test.dart';

void testDays(Map<int, AdventDay> days) {
  for (final AdventDay day in days.values) {
    test('${day.year} day ${day.day}', () {
      if (day.solution1 == null) {
        print('Skipping ${day.year} day ${day.day} part 1 as it is unimplemented.');
      } else {
        expect(day.part1(), day.solution1);
      }
      if (day.solution2 == null) {
        print('Skipping ${day.year} day ${day.day} part 2 as it is unimplemented.');
      } else {
        expect(day.part2(), day.solution2);
      }
    });
  }
}
