// https://adventofcode.com/2016/day/12

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';

import 'assembunny.dart';

main() => Day12().solve();

class Day12 extends AdventDay {
  Day12() : super(2016, 12, name: "Leonardo's Monorail");

  @override
  dynamic part1(String input) => runProgram(input);

  @override
  dynamic part2(String input) => runProgram(input, 1);

  int runProgram(String instructions, [int? ignitionKey]) {
    final machine = Assembunny(instructions.lines);
    if (ignitionKey != null) {
      machine.registers['c'] = ignitionKey;
    }
    machine.execute();
    return machine.registers['a']!;
  }
}
