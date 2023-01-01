import 'dart:io';

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

  String get inputFileName =>
    'input/day${day.toString().padLeft(2, '0')}.txt';

  String input() => File(inputFileName).readAsStringSync().trimRight();

  String _inputData() => File(inputFileName).readAsStringSync().trim();

  List<String> _inputDataLines() => File(inputFileName)
    .readAsLinesSync()
    .where((String e) => e.isNotEmpty)
    .toList();

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
