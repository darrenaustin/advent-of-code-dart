// https://adventofcode.com/2017/day/8

import 'package:aoc/aoc.dart';
import 'package:aoc/util/collection.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day08().solve();

class Day08 extends AdventDay {
  Day08() : super(2017, 8, name: 'I Heard You Like Registers');

  @override
  dynamic part1(String input) {
    final m = Machine();
    for (final instruction in input.lines) {
      m.execute(instruction);
    }
    return m.maxRegister();
  }

  @override
  dynamic part2(String input) {
    final m = Machine();
    return input.lines
        .map((instruction) => (m..execute(instruction)).maxRegister())
        .max;
  }
}

class Machine {
  final Map<String, int> registers = {};

  int register(String name) => registers.getOrElse(name, 0);

  int maxRegister() => registers.isEmpty ? 0 : registers.values.max;

  void execute(String instruction) {
    final [instr, cond] = instruction.split(' if ');
    final [condReg, compare, condValue] = cond.split(' ');
    final condMet = switch (compare) {
      '==' => register(condReg) == int.parse(condValue),
      '!=' => register(condReg) != int.parse(condValue),
      '<' => register(condReg) < int.parse(condValue),
      '<=' => register(condReg) <= int.parse(condValue),
      '>' => register(condReg) > int.parse(condValue),
      '>=' => register(condReg) >= int.parse(condValue),
      _ => throw Exception('Unknown comparison operator: $compare'),
    };
    if (condMet) {
      final [reg, op, value] = instr.split(' ');
      registers[reg] =
          register(reg) + (op == 'dec' ? -1 : 1) * int.parse(value);
    }
  }
}
