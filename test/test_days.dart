import 'package:advent_of_code_dart/day.dart';
import 'package:test/test.dart';

void testDays(List<AdventDay> days) {
  for (final AdventDay day in days) {
    test('${day.year} day ${day.day}', () {
      expect(day.part1(), day.solution1);
      expect(day.part2(), day.solution2);
    });
  }
}
