import 'dart:io';
import 'package:path/path.dart' as path;

final projectLibPath = './lib';
final projectTestPath = "./test";
final projectSrcPath = path.join(projectLibPath, 'src');
final projectSrcDir = Directory(projectSrcPath);

void main(List<String> arguments) {
  updateDayStructures();
}

Future<void> updateDayStructures() async {
  final RegExp yearRegexp = RegExp(r'\d\d\d\d');
  final List<String> years = projectSrcDir.listSync()
      .whereType<Directory>()
      .where((d) => yearRegexp.hasMatch(path.basename(d.path)))
      .map((d) => path.basename(d.path))
      .toList()
    ..sort();
  for (final year in years) {
    writeYearFile(year);
    writeYearTestFile(year);
  }
  writeAllDaysFile(years);
}

void writeYearFile(String year) {
  final RegExp dayRegexp = RegExp(r'day(\d\d).dart');
  final yearDir = Directory(path.join(projectSrcPath, year));
  final List<String> days = yearDir.listSync()
    .whereType<File>()
    .where((d) => dayRegexp.hasMatch(path.basename(d.path)))
    .map((d) => dayRegexp.firstMatch(path.basename(d.path))!.group(1)!)
    .toList()
    ..sort();
  final daysFile = File(path.join(projectLibPath, 'days$year.dart'));
  final out = daysFile.openWrite();
  out.writeln("import 'day.dart';");
  for (final day in days) {
    out.writeln("import 'src/$year/day$day.dart' show Day$day;");
  }
  out.writeln();
  out.writeln("final aoc${year}Days = <int, AdventDay>{");
  for (final day in days) {
    out.writeln("  $day: Day$day(),");
  }
  out.writeln("};");
  out.close();
}

void writeAllDaysFile(List<String> years) {
  final daysFile = File(path.join(projectLibPath, 'days.dart'));
  final out = daysFile.openWrite();
  for (final year in years) {
    out.writeln("import 'package:advent_of_code_dart/days$year.dart';");
  }
  out.writeln();
  out.writeln("import 'day.dart';");
  out.writeln();
  out.writeln("final allYearDays = <int, Map<int, AdventDay>> {");
  for (final year in years) {
    out.writeln("  $year: aoc${year}Days,");
  }
  out.writeln("};");
  out.writeln();
  out.writeln("final List<AdventDay> allDays = <AdventDay>[");
  for (final year in years) {
    out.writeln("  ...aoc${year}Days.values,");
  }
  out.writeln("];");
  out.close();
}

void writeYearTestFile(String year) {
  final testFile = File(path.join(projectTestPath, 'advent${year}_test.dart'));
  final out = testFile.openWrite();
  out.writeln("import 'package:advent_of_code_dart/days$year.dart';");
  out.writeln("import 'package:test/test.dart';");
  out.writeln();
  out.writeln("import 'test_days.dart';");
  out.writeln();
  out.writeln("void main() {");
  out.writeln("  group('$year', () {");
  out.writeln("    testDays(aoc${year}Days);");
  out.writeln("  });");
  out.writeln("}");
  out.close();
}
