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
    print('$year: day $day');
    print('  part 1: ${_format(part1() ?? 'not yet implemented')}');
    print('  part 2: ${_format(part2() ?? 'not yet implemented')}');
    print('');
  }

  String get inputFileName =>
      'input/$year/day${day.toString().padLeft(2, '0')}.txt';

  String inputData() {
    return File(inputFileName).readAsStringSync().trim();
  }

  List<String> inputDataLines() {
    return File(inputFileName)
        .readAsLinesSync()
        .where((String e) => e.isNotEmpty)
        .toList();
  }

  String _format(dynamic value) {
    if (value is double) {
      return value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
    }
    return value.toString();
  }
}
