// https://adventofcode.com/2015/day/6

import 'dart:math';

import 'package:aoc/aoc.dart';
import 'package:aoc/util/grid2.dart';
import 'package:aoc/util/string.dart';
import 'package:aoc/util/vec.dart';
import 'package:collection/collection.dart';

main() => Day06().solve();

class Day06 extends AdventDay {
  Day06() : super(2015, 6, name: 'Probably a Fire Hazard');

  @override
  dynamic part1(String input) {
    final lights = Grid<bool>(1000, 1000, false);

    bool apply(Command command, bool light) =>
        command.type == CommandType.turnOn ||
        (command.type == CommandType.toggle && !light);

    for (final command in input.lines.map(parseCommand)) {
      for (final loc in Vec.range(command.p1, command.p2 + Vec.downRight)) {
        lights.updateCell(loc, (light) => apply(command, light));
      }
    }
    return lights.cellsWhere((on) => on).length;
  }

  @override
  dynamic part2(String input) {
    final lights = Grid<int>(1000, 1000, 0);

    int apply(Command command, int light) {
      switch (command.type) {
        case CommandType.turnOn:
          return light + 1;
        case CommandType.toggle:
          return light + 2;
        case CommandType.turnOff:
          return max(light - 1, 0);
      }
    }

    for (final command in input.lines.map(parseCommand)) {
      for (final loc in Vec.range(command.p1, command.p2 + Vec.downRight)) {
        lights.updateCell(loc, (l) => apply(command, l));
      }
    }
    return lights.cells().sum;
  }

  static final RegExp _commandRegex =
      RegExp(r'^(turn on|toggle|turn off) (\d+),(\d+) through (\d+),(\d+)$');

  static Command parseCommand(String line) {
    final match = _commandRegex.firstMatch(line)!;
    final type = match.group(1)! == 'turn on'
        ? CommandType.turnOn
        : match.group(1)! == 'toggle'
            ? CommandType.toggle
            : CommandType.turnOff;
    return Command(
      type,
      Vec(int.parse(match.group(2)!), int.parse(match.group(3)!)),
      Vec(int.parse(match.group(4)!), int.parse(match.group(5)!)),
    );
  }
}

enum CommandType { turnOn, toggle, turnOff }

class Command {
  Command(this.type, this.p1, this.p2);

  final CommandType type;
  final Vec p1;
  final Vec p2;
}
