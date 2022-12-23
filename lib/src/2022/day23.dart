// https://adventofcode.com/2022/day/23

import 'dart:math';

import 'package:collection/collection.dart';

import '../../day.dart';
import '../util/collection.dart';
import '../util/vec2.dart';

class Day23 extends AdventDay {
  Day23() : super(2022, 23, solution1: 3877, solution2: 982);

  @override
  dynamic part1() {
    final field = Field(inputDataLines());
    for (final _ in range(10)) {
      field.nextRound();
    }
    return field.minimalGridEmptyCells();
  }

  @override
  dynamic part2() {
    final field = Field(inputDataLines());
    while (field.nextRound()) {}
    return field.round;
  }
}

class Field {

  Field(List<String> data) {
    final gridData = data.map((l) => l.split('')).toList();
    for (int y = 0; y < gridData.length; y++) {
      for (int x = 0; x < gridData.first.length; x++) {
        final cell = gridData[y][x];
        if (cell == '#') {
          _elves.add(Vec2.int(x, y));
        }
      }
    }
  }

  int round = 0;
  final Set<Vec2> _elves = {};

  bool nextRound() {
    // Find all elves with at least another around them.
    final movingElves = _elves
      .where((e) => Vec2.aroundDirs.any((d) => _elves.contains(d + e)));

    // Determine the plans for all moving elves.
    final plans = <Vec2, Vec2>{};
    final destinations = <Vec2>{};
    final overbooked = <Vec2>{};
    for (final elf in movingElves) {
      for (final dir in _testDirs) {
        if (dir.$1.map((d) => d + elf).none((p) => _elves.contains(p))) {
          final destination = elf + dir.$0;
          if (destinations.contains(destination)) {
            overbooked.add(destination);
          } else {
            plans[elf] = destination;
            destinations.add(destination);
          }
          break;
        }
      }
    }

    // Move the elves that aren't going to overbooked locations.
    for (final plan in plans.entries) {
      if (!overbooked.contains(plan.value)) {
        _elves.remove(plan.key);
        _elves.add(plan.value);
      }
    }

    // Rotate the test directions
    _testDirs.add(_testDirs.removeAt(0));
    round += 1;

    return plans.isNotEmpty;
  }

  int minimalGridEmptyCells() {
    // Determine minimal grid around elves.
    Vec2 minS = Vec2.zero;
    Vec2 maxS = Vec2.zero;
    for (final elf in _elves) {
      minS = Vec2(min(minS.x, elf.x), min(minS.y, elf.y));
      maxS = Vec2(max(maxS.x, elf.x), max(maxS.y, elf.y));
    }

    // Calculate the empty cells in the grid.
    final span = maxS - minS;
    final numCells = (span.xInt + 1) * (span.yInt + 1);
    return numCells - _elves.length;
  }

  // Direction to travel if there are no neighbors in the directions list.
  final List<(Vec2, List<Vec2>)> _testDirs = [
    (Vec2.up, [Vec2.upLeft, Vec2.up, Vec2.upRight]),
    (Vec2.down, [Vec2.downLeft, Vec2.down, Vec2.downRight]),
    (Vec2.left, [Vec2.upLeft, Vec2.left, Vec2.downLeft]),
    (Vec2.right, [Vec2.upRight, Vec2.right, Vec2.downRight]),
  ];
}
