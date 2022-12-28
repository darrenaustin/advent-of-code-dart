// https://adventofcode.com/2022/day/25

import 'dart:math';

import '../../day.dart';
import '../util/collection.dart';

class Day25 extends AdventDay {
  Day25() : super(2022, 25, solution1: '20===-20-020=0001-02', solution2: 'got em all!');

  @override
  dynamic part1() => intSnafu(inputDataLines().map(snafuInt).sum);

  @override
  dynamic part2() => 'got em all!';

  final digitValues = { '=': -2, '-': -1, '0': 0, '1': 1, '2': 2 };
  int snafuInt(String s) => s.split('')
    .reversed
    .mapIndexed((p, d) => pow(5, p).toInt() * digitValues[d]!)
    .sum;

  final unit = ['=', '-', '0', '1', '2'];
  String intSnafu(int n) =>
    n == 0
      ? ''
      : intSnafu((n + 2) ~/ 5) + unit[(n + 2) % 5];
}