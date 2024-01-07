// https://adventofcode.com/2019/day/1

import 'dart:math';

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day01().solve();

class Day01 extends AdventDay {
  Day01() : super(2019, 1, name: 'The Tyranny of the Rocket Equation');

  @override
  dynamic part1(String input) {
    return inputMasses(input).map(fuelFor).sum;
  }

  @override
  dynamic part2(String input) {
    return inputMasses(input).map(totalFuelFor).sum;
  }

  Iterable<int> inputMasses(String input) => input.lines.map(int.parse);

  static int fuelFor(int mass) => mass ~/ 3 - 2;

  static int totalFuelFor(int mass) {
    if (mass <= 0) return 0;
    final fuel = max(fuelFor(mass), 0);
    return fuel + totalFuelFor(fuel);
  }
}
