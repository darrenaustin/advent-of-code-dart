import 'dart:io';
import 'package:collection/collection.dart';
import 'package:path/path.dart' as path;

final packagesPath = './packages';
final projectLibPath = './lib';
final projectTestPath = "./test";

void main(List<String> arguments) => updateDayStructures();

Future<void> updateDayStructures() async {
  final years = activeYears();
  await writeAllDaysFile(years);
  for (final year in years) {
    await updateYearFiles(year);
  }
}

List<String> activeYears() {
  final yearPackagePattern = RegExp(r'aoc\d{4}');
  final packages = Directory(packagesPath);
  return packages
    .listSync()
    .whereType<Directory>()
    .map((d) => path.basename(d.path))
    .where((p) => yearPackagePattern.hasMatch(p))
    .map((s) => s.substring(3))
    .sorted()
    .toList();
}

Future<void> updateYearFiles(String year) async {
  final yearLibPath = path.join(packagesPath, 'aoc$year', 'lib');
  final yearSrcPath = path.join(yearLibPath, 'src');
  final yearTestPath = path.join(packagesPath, 'aoc$year', 'test');
  final dayDir = Directory(yearSrcPath);
  final RegExp dayRegexp = RegExp(r'day(\d\d).dart');
  final List<String> days = dayDir.listSync()
    .whereType<File>()
    .where((d) => dayRegexp.hasMatch(path.basename(d.path)))
    .map((d) => dayRegexp.firstMatch(path.basename(d.path))!.group(1)!)
    .toList()
    ..sort();

  final packageFile = File(path.join(yearLibPath, 'aoc$year.dart'));
  final out = packageFile.openWrite();
  out.writeln('library aoc$year;');
  out.writeln();
  out.writeln("import 'package:aoc/aoc.dart';");
  for (final day in days) {
    out.writeln("import 'src/day$day.dart' show Day$day;");
  }
  out.writeln();
  out.writeln("final aoc${year}Days = <int, AdventDay>{");
  for (final day in days) {
    out.writeln("  $day: Day$day(),");
  }
  out.writeln("};");
  await out.close();

  for (final day in days) {
    await migrateDay(yearSrcPath, year, day);
    await writeTestFile(yearTestPath, year, day);
  }
}

Future<void> migrateDay(String dirPath, String year, String day) async {
  final dayFile = File(path.join(dirPath, 'day$day.dart'));
  if (!dayFile.existsSync()) return;

  final origContents = dayFile.readAsStringSync().replaceAll('\n', '\n// ');
  final dayNum = int.parse(day);

  final mainIndex = origContents.indexOf('main() => Day');
  if (mainIndex != -1) return;

  final out = dayFile.openWrite();
  out.writeln("// https://adventofcode.com/$year/day/$dayNum");
  out.writeln();
  out.writeln("import 'package:aoc/aoc.dart';");
  out.writeln();
  out.writeln("main() => Day$day().solve();");
  out.writeln();
  out.writeln("class Day$day extends AdventDay {");
  out.writeln("  Day$day() : super(");
  out.writeln("    $year, $dayNum, name: '',");
  out.writeln("  );");
  out.writeln();
  out.writeln("  @override");
  out.writeln("  dynamic part1(String input) => 'Need to migrate';");
  out.writeln();
  out.writeln("  @override");
  out.writeln("  dynamic part2(String input) => 'Need to migrate';");
  out.writeln("}");
  out.writeln();
  out.write(origContents);
  await out.close();
}

Future<void> writeTestFile(String dirPath, String year, String day) async {
  final testFile = File(path.join(dirPath, 'day${day}_test.dart'));
  if (testFile.existsSync()) return;

  final out = testFile.openWrite();
  out.writeln("import 'package:aoc$year/src/day$day.dart';");
  out.writeln("import 'package:test/test.dart';");
  out.writeln();
  out.writeln("main() {");
  out.writeln("  group('$year Day $day', () {");
  out.writeln("    group('part 1', () {");
  out.writeln("      test('examples', () {");
  out.writeln("        // expect(Day$day().part1(''), 0); ");
  out.writeln("      });");
  out.writeln();
  out.writeln("      test('solution', () {");
  out.writeln("        final day = Day$day();");
  out.writeln("        final result = day.part1(day.input());");
  out.writeln("        if (day.solution1 == null) {");
  out.writeln("          print('Unknown solution \$result');");
  out.writeln("        } else {");
  out.writeln("          expect(result, day.solution1); ");
  out.writeln("        }");
  out.writeln("      });");
  out.writeln("    });");
  out.writeln();
  out.writeln("    group('part 2', () {");
  out.writeln("      test('examples', () {");
  out.writeln("        // expect(Day$day().part2(')'), 1); ");
  out.writeln("      });");
  out.writeln();
  out.writeln("      test('solution', () {");
  out.writeln("        final day = Day$day();");
  out.writeln("        final result = day.part2(day.input());");
  out.writeln("        if (day.solution2 == null) {");
  out.writeln("          print('Unknown solution \$result');");
  out.writeln("        } else {");
  out.writeln("          expect(result, day.solution2); ");
  out.writeln("        }");
  out.writeln("      });");
  out.writeln("    });");
  out.writeln("  });");
  out.writeln("}");
  await out.close();
}

Future<void> writeAllDaysFile(List<String> years) async {
  final daysFile = File(path.join(projectLibPath, 'days.dart'));
  final out = daysFile.openWrite();
  out.writeln("import 'package:aoc/aoc.dart';");
  for (final year in years) {
    out.writeln("import 'package:aoc$year/aoc$year.dart';");
  }
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
  await out.close();
}
