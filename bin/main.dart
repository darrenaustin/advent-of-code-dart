import 'package:advent_of_code_dart/day.dart';
import 'package:advent_of_code_dart/days2015.dart';
import 'package:advent_of_code_dart/days2016.dart';
import 'package:advent_of_code_dart/days2021.dart';
import 'package:args/args.dart';

final Map<int, List<AdventDay>> yearDays = <int, List<AdventDay>> {
  2015: adventOfCode2015Days,
  2016: adventOfCode2016Days,
  2021: adventOfCode2021Days,
};

final List<AdventDay> allAdventOfCodeDays = <AdventDay>[
  ...adventOfCode2015Days,
  ...adventOfCode2016Days,
  ...adventOfCode2021Days,
];

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
