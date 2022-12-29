import 'package:aoc/aoc.dart';
import 'package:args/args.dart';

import 'package:advent_of_code_dart/days.dart';

void main(List<String> arguments) {

  List<AdventDay> days = allDays;

  final ArgParser parser = ArgParser();
  parser.addOption('year', abbr: 'y');

  final ArgResults parsed = parser.parse(arguments);
  final String? year = parsed['year'] as String?;
  if (year != null) {
    final int? yearNum = int.tryParse(year);
    if (yearNum == null || !allYearDays.containsKey(yearNum)) {
      throw Exception('Invalid year: $year');
    }
    final yearDays = allYearDays[yearNum]!;
    days = yearDays.values.toList();

    if (parsed.rest.isNotEmpty) {
      for (final String day in parsed.rest) {
        final int? dayNum = int.tryParse(day);
        if (dayNum != null) {
          if (yearDays.containsKey(dayNum)) {
            yearDays[dayNum]!.solve();
          } else {
            print('No solution for $year day $day');
          }
        } else {
          print('Unknown day number: $day');
        }
      }
    }
  } else {
    // Solve all of them
    for (final AdventDay day in days) {
      day.solve();
    }
  }
}
