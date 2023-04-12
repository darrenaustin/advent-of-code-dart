import 'dart:convert';
import 'dart:io';
import 'package:aoc/aoc.dart';
import 'package:args/args.dart';
import 'package:path/path.dart' as path;

import 'update_days.dart';

void main(List<String> arguments) async {

  final ArgParser parser = ArgParser();
  parser.addOption('year', abbr: 'y', mandatory: true);
  parser.addOption('day', abbr: 'd', mandatory: true);

  final ArgResults parsed = parser.parse(arguments);
  final int? yearNum = int.tryParse(parsed['year']);
  final int? dayNum = int.tryParse(parsed['day']);
  if (yearNum == null) {
    throw('Invalid year: $yearNum');
  }
  if (dayNum == null) {
    throw('Invalid day: $dayNum');
  }

  String year = yearNum.toString();
  String day = dayNum.toString().padLeft(2, '0');

  // Create the skeleton for the day's solution
  final dayFilePath = path.join(packagesPath, 'aoc$year', 'lib', 'src', 'day$day.dart');
  final dayFile = File(dayFilePath);
  if (!dayFile.existsSync()) {
    dayFile.createSync(recursive: true);
    final out = dayFile.openWrite();
    out.writeln("// https://adventofcode.com/$year/day/$dayNum");
    out.writeln();
    out.writeln("import 'package:aoc/aoc.dart';");
    out.writeln();
    out.writeln("main() => Day$day().solve();");
    out.writeln();
    out.writeln("class Day$day extends AdventDay {");
    out.writeln("  Day$day() : super($year, $dayNum, name: '');");
    out.writeln();
    out.writeln("  @override");
    out.writeln("  dynamic part1(String input) {");
    out.writeln("  }");
    out.writeln();
    out.writeln("  @override");
    out.writeln("  dynamic part2(String input) {");
    out.writeln("  }");
    out.writeln("}");
    await out.close();
  }

  // Update the day structures across the repo.
  await updateDayStructures();

  final sessionFile = File(path.join(Directory.current.path, ".session"));

  // Move into the package directory so that the relative
  // input paths work correctly.
  Directory.current = path.join(packagesPath, 'aoc$year');

  // Create an empty input file
  final inputFile = File(path.join(AdventDay.inputRepoBase, year, '${day}_input.txt'));
  if (!inputFile.existsSync()) {
    inputFile.createSync(recursive: true);

    // Try to copy the input file from the website.
    String? sessionId;
    if (sessionFile.existsSync()) {
      sessionId = sessionFile.readAsStringSync().trim();
    }
    if (sessionId == null) {
      print('No session data found, unable to download input file');
    } else {
      final inputURL = Uri.parse("https://adventofcode.com/$year/day/$dayNum/input");
      print('Fetching input data: $inputURL');
      final client = HttpClient();
      try {
        final request = await client.getUrl(inputURL);
        request.cookies.add(Cookie("session", sessionId));
        final response = await request.close();
        if (response.statusCode == HttpStatus.ok) {
          // Write the text to the input file
          final contents = await response.transform(utf8.decoder).join();
          inputFile.writeAsStringSync(contents);
          print('Input data successfully downloaded');
        } else {
          print('Unable to fetch input data, code = ${response.statusCode}');
        }
      } finally {
        client.close();
      }
    }
  }

  // Create an empty answer file
  final answerFile = File(path.join(AdventDay.inputRepoBase, year, '${day}_answer.json'));
  if (!answerFile.existsSync()) {
    answerFile.createSync(recursive: true);
    answerFile.writeAsStringSync('{\n}\n\n');
  }

  exit(0);
}
