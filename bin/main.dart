import 'package:advent_of_code_dart/day.dart';
import 'package:args/args.dart';

import 'package:advent_of_code_dart/days.dart';

void main(List<String> arguments) {

  List<AdventDay> days = allAdventOfCodeDays;

  final ArgParser parser = ArgParser();
  parser.addOption('year', abbr: 'y');

  final ArgResults parsed = parser.parse(arguments);
  final String? year = parsed['year'] as String?;
  if (year != null) {
    final int? yearNum = int.tryParse(year);
    if (yearNum == null || !yearDays.containsKey(yearNum)) {
      throw Exception('Invalid year: $year');
    }
    days = yearDays[yearNum]!;
  }
  if (parsed.rest.isNotEmpty) {
    for (final String day in parsed.rest) {
      final int? dayNum = int.tryParse(day);
      if (dayNum != null) {
        days[dayNum - 1].solve();
      } else {
        print('Unknown day number: $day');
      }
    }
  } else {
    // Solve all of them
    for (final AdventDay day in days) {
      day.solve();
    }
  }
}
