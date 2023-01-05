import 'dart:io';

abstract class AdventDay {
  AdventDay(this.year, this.day, {this.solution1, this.solution2});

  final int year;

  final int day;

  dynamic part1();

  final dynamic solution1;

  dynamic part2();

  final dynamic solution2;

  void solve() {
    void part(int partNum) {
      final start = DateTime.now();
      final solution = partNum == 1 ? part1() : part2();
      final time = DateTime.now().difference(start).inMilliseconds;
      print('  part $partNum: ${_results(solution, partNum == 1 ? solution1 : solution2, time)}');
    }

    print('$year: day $day');
    part(1);
    part(2);
    print('');
  }

  String get inputFileName =>
    'input/$year/day${day.toString().padLeft(2, '0')}.txt';

  String input() {
    return File(inputFileName).readAsStringSync();
  }

  String inputData() {
    return File(inputFileName).readAsStringSync().trim();
  }

  List<String> inputDataLines() {
    return File(inputFileName)
      .readAsLinesSync()
      .where((String e) => e.isNotEmpty)
      .toList();
  }

  String _results(dynamic solution, dynamic expected, int time) {
    if (solution == null) {
      return 'not yet implemented';
    }
    final String correct = expected != null ? expected == solution ? 'correct, ' : 'INCORRECT, ' : '';
    return '${_format(solution)}, ($correct$time ms)';
  }

  String _format(dynamic value) {
    if (value is double) {
      return value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
    }
    return value.toString();
  }
}
