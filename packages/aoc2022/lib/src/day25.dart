// https://adventofcode.com/2022/day/25

import 'dart:math';

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day25().solve();

class Day25 extends AdventDay {
  Day25() : super(2022, 25, name: 'Full of Hot Air');

  @override
  dynamic part1(String input) => intSnafu(input.lines.map(snafuInt).sum);

  @override
  dynamic part2(String input) => AdventDay.lastStarSolution;

  static final digitValues = {'=': -2, '-': -1, '0': 0, '1': 1, '2': 2};
  static int snafuInt(String s) => s
      .split('')
      .reversed
      .mapIndexed((p, d) => pow(5, p).toInt() * digitValues[d]!)
      .sum;

  static final unit = ['=', '-', '0', '1', '2'];
  static String intSnafu(int n) =>
      n == 0 ? '' : intSnafu((n + 2) ~/ 5) + unit[(n + 2) % 5];
}
