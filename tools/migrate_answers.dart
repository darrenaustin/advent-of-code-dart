// import 'dart:convert';
import 'dart:io';

import 'package:advent_of_code_dart/days.dart';
import 'package:aoc/aoc.dart';
import 'package:path/path.dart' as path;

final packagesPath = './packages';

void main(List<String> arguments) {
  for (final day in allDays) {
    final origDirectory = Directory.current;
    Directory.current = path.join(packagesPath, 'aoc${day.year}');

    createAnswerFile(day);
    moveInputFile(day);
    updateSolutionFile(day);

    Directory.current = origDirectory;
  }
}

void createAnswerFile(AdventDay day) {
  // final answerFile = File(path.join(AdventDay.inputRepoBase, day.year.toString(), '${day.day.toString().padLeft(2, '0')}_answer.json'));
  // if (!answerFile.existsSync()) {
  //   final answerData = {
  //     'answer1': day.solution1,
  //     'answer2': day.solution2,
  //   };
  //   JsonEncoder encoder = JsonEncoder.withIndent('  ');
  //   answerFile.createSync(recursive: true);
  //   answerFile.writeAsStringSync(encoder.convert(answerData));
  // }
}

void moveInputFile(AdventDay day) {
  final inputFile = File(path.join(AdventDay.inputRepoBase, day.year.toString(), 'day${day.day.toString().padLeft(2, '0')}.txt'));
  if (inputFile.existsSync()) {
    final newPath = path.join(AdventDay.inputRepoBase, day.year.toString(), '${day.day.toString().padLeft(2, '0')}_input.txt');
    inputFile.renameSync(newPath);
  }
}

void updateSolutionFile(AdventDay day) {
  final dayText = day.day.toString().padLeft(2, '0');
  final sourceFile = File('./lib/src/day$dayText.dart');
  if (sourceFile.existsSync()) {
    final constructorRegexp = RegExp(r'Day\d\d\(\) : super\([\W+](.*)solution1:.*?\);', multiLine: true, dotAll: true);
    final contents = sourceFile.readAsStringSync();
    final matching = constructorRegexp.firstMatch(contents);
    if (matching != null) {
      final args = matching.group(1)!.trim();
      final updatedText = 'Day$dayText() : super(${args.substring(0, args.length - 1)});';
      final updatedContents = contents.replaceRange(matching.start, matching.end, updatedText);
      sourceFile.writeAsStringSync(updatedContents);
    }
  }
}
