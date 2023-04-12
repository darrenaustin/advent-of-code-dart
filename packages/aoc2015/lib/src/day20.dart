// https://adventofcode.com/2015/day/20

import 'dart:math';

import 'package:aoc/aoc.dart';
import 'package:aoc/util/math.dart';

main() => Day20().solve();

class Day20 extends AdventDay {
  Day20() : super(2015, 20, name: 'Infinite Elves and Infinite Houses');

  @override
  dynamic part1(String input) => firstHouseThatGets(int.parse(input), 10);

  @override
  dynamic part2(String input) => firstHouseThatGets(int.parse(input), 11, 50);

  int firstHouseThatGets(int target, int elfPresents, [int elfHouseLimit = maxInt]) {
    final size = target ~/ elfPresents;
    final houses = List.generate(size, (_) => 0);
    for (int elf = 1; elf < size; elf++) {
      final lastElfHouse = min(size ~/ elf, elfHouseLimit);
      for (int elfFactor = 1; elfFactor <= lastElfHouse; elfFactor++) {
        houses[elfFactor * elf - 1] += elf * elfPresents;
      }
      if (houses[elf - 1] >= target) {
        return elf;
      }
    }
    throw 'No solution';
  }
}
