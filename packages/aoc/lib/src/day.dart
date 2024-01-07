import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:test/test.dart';

abstract class AdventDay {
  AdventDay(this.year, this.day, {this.name});

  final int year;
  final int day;
  final String? name;

  late final Map<String, dynamic> _answers = _loadAnswers(year, day);
  dynamic get answer1 => _answers['answer1'];
  dynamic get answer2 => _answers['answer2'];

  dynamic part1(String input);

  dynamic part2(String input);

  void solve() {
    void part(int partNum) {
      final inputText = input();
      final start = DateTime.now();
      final answer = partNum == 1 ? part1(inputText) : part2(inputText);
      final time = DateTime.now().difference(start).inMilliseconds;
      print(
          '  part $partNum: ${_results(answer, partNum == 1 ? answer1 : answer2, time)}');
    }

    print('$year Day $day: ${name ?? ''}\n');
    part(1);
    part(2);
    print('');
  }

  void testPart1() {
    final result = part1(input());
    if (answer1 == null) {
      print('$year, $day part 1 - unverified answer $result');
    } else {
      expect(result, answer1);
    }
  }

  void testPart2() {
    final result = part2(input());
    if (answer2 == null) {
      print('$year, $day part 2 - unverified answer $result');
    } else {
      expect(result, answer2);
    }
  }

  String input() => File(_inputFileName).readAsStringSync().trimRight();

  static const lastStarSolution = '🎄 Got em all! 🎉';

  static final inputRepoBase = String.fromEnvironment('INPUT_REPO',
      defaultValue: '../../../advent_of_code_input');

  String get _inputFileName =>
      '$inputRepoBase/$year/${day.toString().padLeft(2, '0')}_input.txt';

  String _results(dynamic answer, dynamic expected, int time) {
    if (answer == null) {
      return 'not yet implemented';
    }
    final String correct = expected != null
        ? expected == answer
            ? 'correct, '
            : 'INCORRECT, '
        : '';
    return '${_format(answer)}, ($correct$time ms)';
  }

  String _format(dynamic value) {
    if (value is double) {
      return value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
    }
    return value.toString();
  }

  static Map<String, dynamic> _loadAnswers(int year, int day) {
    final answerFile = File(path.join(inputRepoBase, year.toString(),
        '${day.toString().padLeft(2, '0')}_answer.json'));
    if (answerFile.existsSync()) {
      try {
        return jsonDecode(answerFile.readAsStringSync());
      } catch (_) {}
    }
    return {};
  }
}
