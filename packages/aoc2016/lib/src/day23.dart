// https://adventofcode.com/2016/day/23

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';

import 'assembunny.dart';

main() => Day23().solve();

class Day23 extends AdventDay {
  Day23() : super(2016, 23, name: 'Safe Cracking');

  @override
  dynamic part1(String input) => sendPassword(input, 7);

  @override
  dynamic part2(String input) => sendPassword(input, 12);

  int sendPassword(String instructions, int inputCode) {
    final machine = Assembunny(instructions.lines);
    machine.registers['a'] = inputCode;
    machine.execute();
    return machine.registers['a']!;
  }
}
