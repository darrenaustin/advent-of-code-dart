// https://adventofcode.com/2015/day/2

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day02().solve();

class Day02 extends AdventDay {
  Day02() : super(
    2015, 2, name: 'I Was Told There Would Be No Math',
    solution1: 1598415, solution2: 3812909,
  );

  @override
  dynamic part1(String input) => input
    .lines
    .map(parsePackage)
    .map(wrapNeededFor)
    .sum;

  @override
  dynamic part2(String input) => input
    .lines
    .map(parsePackage)
    .map(ribbonNeededFor)
    .sum;

  static List<int> parsePackage(String input) => input
    .split('x')
    .map(int.parse)
    .toList()
    ..sort();

  static int wrapNeededFor(List<int> dimens) =>
    3 * (dimens[0] * dimens[1]) + // smallest side counts one extra.
    2 * (dimens[1] * dimens[2]) +
    2 * (dimens[0] * dimens[2]);

  static int ribbonNeededFor(List<int> dimens) =>
    2 * (dimens[0] + dimens[1]) + (dimens[0] * dimens[1] * dimens[2]);
}
