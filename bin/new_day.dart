import 'dart:convert';
import 'dart:io';
import 'package:args/args.dart';
import 'package:path/path.dart' as path;

import 'update_days.dart';

final projectInputPath = "./input";

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
  final dayFilePath = path.join(projectSrcPath, year, 'day$day.dart');
  final dayFile = File(dayFilePath);
  if (!dayFile.existsSync()) {
    dayFile.createSync(recursive: true);
    final out = dayFile.openWrite();
    out.writeln("// https://adventofcode.com/$year/day/$dayNum");
    out.writeln();
    out.writeln("import '../../day.dart';");
    out.writeln();
    out.writeln("class Day$day extends AdventDay {");
    out.writeln("  Day$day() : super($year, $dayNum);");
    out.writeln();
    out.writeln("  @override");
    out.writeln("  dynamic part1() {");
    out.writeln("    return null;");
    out.writeln("  }");
    out.writeln();
    out.writeln("  @override");
    out.writeln("  dynamic part2() {");
    out.writeln("    return null;");
    out.writeln("  }");
    out.writeln("}");
    out.close();
  }

  // Create an empty input file
  final inputFilePath = path.join(projectInputPath, year, 'day$day.txt');
  final inputFile = File(inputFilePath);
  inputFile.createSync(recursive: true);

  // Try to copy the input file from the website.
  String? sessionId;
  File sessionFile = File("./.session");
  if (sessionFile.existsSync()) {
    sessionId = sessionFile.readAsStringSync().trim();
  }
  if (sessionId == null) {
    print('No session data found, unable to download input file');
    exit(0);
  }
  final inputURL = Uri.parse("https://adventofcode.com/$year/day/$dayNum/input");
  print('Fetching input data: $inputURL');
  final request = await HttpClient().getUrl(inputURL);
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

  // Update the day structures across the repo.
  updateDayStructures();
}
