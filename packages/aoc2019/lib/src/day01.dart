// https://adventofcode.com/2019/day/1

import 'package:aoc/aoc.dart';
import 'package:collection/collection.dart';

class Day01 extends AdventDay {
  Day01() : super(2019, 1, solution1: 3371958, solution2: 5055050);

  @override
  dynamic part1() {
    return inputMasses().map(fuelFor).sum;
  }

  @override
  dynamic part2() {
    return inputMasses().map(totalFuelFor).sum;
  }

  Iterable<int>inputMasses() {
    return inputDataLines().map(int.parse);
  }

  int fuelFor(int mass) {
    return mass ~/ 3 - 2;
  }

  int totalFuelFor(int mass) {
    var totalMass = 0;
    while (mass > 0) {
      final fuel = fuelFor(mass);
      if (fuel > 0) {
        totalMass += fuel;
      }
      mass = fuel;
    }
    return totalMass;
  }
}
