import 'dart:io';
import 'package:test/test.dart';

abstract class AdventDay {
  AdventDay(this.year, this.day, {this.name, this.solution1, this.solution2});

  final int year;
  final int day;
  final String? name;
  final dynamic solution1;
  final dynamic solution2;

  dynamic part1(String input);

  dynamic part2(String input);

  void solve() {
    void part(int partNum) {
      final inputText = input();
      final start = DateTime.now();
      final solution = partNum == 1 ? part1(inputText) : part2(inputText);
      final time = DateTime.now().difference(start).inMilliseconds;
      print('  part $partNum: ${_results(solution, partNum == 1 ? solution1 : solution2, time)}');
    }

    print('$year: day $day ${name ?? ''}\n');
    part(1);
    part(2);
    print('');
  }

  void testPart1() {
    final result = part1(input());
    if (solution1 == null) {
      print('$year, $day part 1 - unknown solution $result');
    } else {
      expect(result, solution1); 
    }
  }

  void testPart2() {
    final result = part2(input());
    if (solution2 == null) {
      print('$year, $day part 2 - unknown solution $result');
    } else {
      expect(result, solution2); 
    }
  }

  String input() => File(_inputFileName).readAsStringSync().trimRight();

  static const lastStarSolution = '🎄 Got em all! 🎉';

  String get _inputFileName =>
    'input/day${day.toString().padLeft(2, '0')}.txt';

  String _results(dynamic solution, dynamic expected, int time) {
    if (solution == null) {
      return 'not yet implemented';
    }
    final String correct = expected != null
      ? expected == solution
        ? 'correct, '
        : 'INCORRECT, '
      : '';
    return '${_format(solution)}, ($correct$time ms)';
  }

  String _format(dynamic value) {
    if (value is double) {
      return value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
    }
    return value.toString();
  }
}
