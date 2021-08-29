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
    final Grid<bool> lights = Grid<bool>(1000, 1000, false);
    bool apply(final Instruction i, bool value) =>
      i.type == InstructionType.turnOn ||
      (i.type == InstructionType.toggle && !value);

    inputInstructions().forEach((Instruction i) =>
      region(i.p1, i.p2).forEach((Vector v) =>
          lights.setCell(v, apply(i, lights.cell(v)))));
    return lights.cellsWhere((bool value) => value).length;
  }

  @override
  dynamic part2() {
    final Grid<int> lights = Grid<int>(1000, 1000, 0);
    int apply(final Instruction i, int value) {
      switch (i.type) {
        case InstructionType.turnOn: return value + 1;
        case InstructionType.toggle: return value + 2;
        case InstructionType.turnOff: return max(value - 1, 0);
      }
    }

    inputInstructions().forEach((Instruction i) =>
        region(i.p1, i.p2).forEach((Vector v) =>
            lights.setCell(v, apply(i, lights.cell(v)))));
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
          Vector.int(int.parse(match.group(2)!), int.parse(match.group(3)!)),
          Vector.int(int.parse(match.group(4)!), int.parse(match.group(5)!)));
    });
  }

  Iterable<Vector> region(Vector p1, Vector p2) sync* {
    for (double y = p1.y; y <= p2.y; y++) {
      for (double x = p1.x; x <= p2.x; x++) {
        yield Vector(x, y);
      }
    }
  }
}

enum InstructionType { turnOn, toggle, turnOff }

class Instruction {
  Instruction(this.type, this.p1, this.p2);

  final InstructionType type;
  final Vector p1;
  final Vector p2;
}
