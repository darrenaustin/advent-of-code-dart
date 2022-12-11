// https://adventofcode.com/2015/day/6

import 'dart:math';

import '../../day.dart';
import '../util/collection.dart';
import '../util/grid2.dart';
import '../util/vec2.dart';

class Day06 extends AdventDay {
  Day06() : super(2015, 6, solution1: 543903, solution2: 14687245);

  @override
  dynamic part1() {
    final lights = Grid<bool>(1000, 1000, false);
    bool apply(final Instruction i, bool value) =>
      i.type == InstructionType.turnOn ||
      (i.type == InstructionType.toggle && !value);

    for (final instruction in inputInstructions()) {
      for (int y = instruction.p1.yInt; y <= instruction.p2.y; y++) {
        for (int x = instruction.p1.xInt; x <= instruction.p2.x; x++) {
          final loc = Vec2.int(x, y);
          lights.setCell(loc, apply(instruction, lights.cell(loc)));
        }
      }
    }
    return lights.cellsWhere((bool value) => value).length;
  }

  @override
  dynamic part2() {
    final lights = Grid<int>(1000, 1000, 0);
    int apply(final Instruction i, int value) {
      switch (i.type) {
        case InstructionType.turnOn: return value + 1;
        case InstructionType.toggle: return value + 2;
        case InstructionType.turnOff: return max(value - 1, 0);
      }
    }

    for (final instruction in inputInstructions()) {
      for (int y = instruction.p1.yInt; y <= instruction.p2.y; y++) {
        for (int x = instruction.p1.xInt; x <= instruction.p2.x; x++) {
          final loc = Vec2.int(x, y);
          lights.setCell(loc, apply(instruction, lights.cell(loc)));
        }
      }
    }
    return lights.cells().sum();
  }

  Iterable<Instruction> inputInstructions() {
    final RegExp instructionRegex = RegExp(r'^(turn on|toggle|turn off) (\d+),(\d+) through (\d+),(\d+)$');
    return inputDataLines().map((String line) {
      final RegExpMatch match = instructionRegex.firstMatch(line)!;
      final InstructionType type =
        match.group(1)! == 'turn on'
          ? InstructionType.turnOn
          : match.group(1)! == 'toggle'
              ? InstructionType.toggle
              : InstructionType.turnOff;
      return Instruction(
        type,
        Vec2.int(int.parse(match.group(2)!), int.parse(match.group(3)!)),
        Vec2.int(int.parse(match.group(4)!), int.parse(match.group(5)!))
      );
    });
  }
}

enum InstructionType { turnOn, toggle, turnOff }

class Instruction {
  Instruction(this.type, this.p1, this.p2);

  final InstructionType type;
  final Vec2 p1;
  final Vec2 p2;
}
