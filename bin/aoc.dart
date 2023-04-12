import 'dart:io';
import 'package:advent_of_code_dart/days.dart';
import 'package:path/path.dart' as path;
import 'package:aoc/aoc.dart';
import 'package:args/args.dart';

final String packageDir = path.join(Directory.current.path, 'packages');

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
      days = [];
      for (final String day in parsed.rest) {
        final int? dayNum = int.tryParse(day);
        if (dayNum != null) {
          if (yearDays.containsKey(dayNum)) {
            days.add(yearDays[dayNum]!);
          } else {
            print('No solution for $year day $day');
          }
        } else {
          print('Unknown day number: $day');
        }
      }
    }
  }

  // Solve the days specified
  for (final AdventDay day in days) {
    cdPackagePath(day.year);
    day.solve();
  }
}

void cdPackagePath(int year) =>
  Directory.current = path.join(packageDir, 'aoc$year');
