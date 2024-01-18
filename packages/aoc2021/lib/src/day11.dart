// https://adventofcode.com/2021/day/11

import 'package:aoc/aoc.dart';
import 'package:aoc/util/grid.dart';
import 'package:aoc/util/range.dart';
import 'package:aoc/util/string.dart';
import 'package:aoc/util/vec.dart';
import 'package:collection/collection.dart';

main() => Day11().solve();

class Day11 extends AdventDay {
  Day11() : super(2021, 11, name: 'Dumbo Octopus');

  @override
  dynamic part1(String input) {
    final grid = parseGrid(input);
    return range(100).map((_) => stepGrid(grid)).sum;
  }

  @override
  dynamic part2(String input) {
    final grid = parseGrid(input);
    int step = 0;
    while (!grid.values().every((e) => e == 0)) {
      stepGrid(grid);
      step++;
    }
    return step;
  }

  int stepGrid(Grid<int> grid) {
    grid.updateValues((e) => e + 1);
    final flashes = <Vec>{};
    final needFlashes = grid.locationsWhereValue((v) => v > 9).toList();
    while (needFlashes.isNotEmpty) {
      final flash = needFlashes.removeLast();
      if (!flashes.contains(flash)) {
        flashes.add(flash);
        for (final (neighbor, energy) in grid.neighborCells(flash)) {
          final updatedEnergy = energy + 1;
          grid.setValue(neighbor, updatedEnergy);
          if (updatedEnergy > 9 && !flashes.contains(neighbor)) {
            needFlashes.add(neighbor);
          }
        }
      }
    }
    for (final flash in flashes) {
      grid.setValue(flash, 0);
    }
    return flashes.length;
  }

  Grid<int> parseGrid(String input) => Grid.from(
      input.lines.map((l) => l.chars.map(int.parse).toList()).toList(), 0);
}
