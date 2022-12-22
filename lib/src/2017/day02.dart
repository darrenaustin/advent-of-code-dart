// https://adventofcode.com/2017/day/2

import 'package:collection/collection.dart';

import '../../day.dart';

class Day02 extends AdventDay {
  Day02() : super(2017, 2, solution1: 45351, solution2: 275);

  @override
  dynamic part1() {
    return inputRows()
      .map((r) => r.max - r.min)
      .sum;
  }

  @override
  dynamic part2() {
    return inputRows()
      .map((r) {
        for (int a = 0; a < r.length - 1; a++) {
          for (int b = a + 1; b < r.length; b++) {
            if (r[a] % r[b] == 0) return r[a] / r[b];
            if (r[b] % r[a] == 0) return r[b] / r[a];
          }
        }
        throw('No divisible pair on row: $r');
      })
      .sum;
  }

  List<List<int>> inputRows() => inputDataLines()
    .map((l) => l.split(RegExp(r'\W+')).map(int.parse).toList())
    .toList();
}
