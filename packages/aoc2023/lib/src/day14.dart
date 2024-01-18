// https://adventofcode.com/2023/day/14

import 'package:aoc/aoc.dart';
import 'package:aoc/util/grid2.dart';
import 'package:aoc/util/vec2.dart';
import 'package:collection/collection.dart';

main() => Day14().solve();

class Day14 extends AdventDay {
  Day14() : super(2023, 14, name: 'Parabolic Reflector Dish');

  @override
  dynamic part1(String input) {
    Grid<String> grid = Grid.fromString(input);
    tilt(grid, Vec2.up);
    return load(grid);
  }

  @override
  dynamic part2(String input) {
    Grid<String> grid = Grid.fromString(input);
    final seen = <Grid<String>>[];
    int? cycleStart;
    int? cyclePeriod;
    int current = 0;
    while (cyclePeriod == null) {
      seen.add(grid.copy());
      cycle(grid);
      final seenIndex = seen.indexOf(grid);
      if (seenIndex != -1) {
        if (cyclePeriod == null) {
          cyclePeriod = current - seenIndex + 1;
          cycleStart = seenIndex;
        }
      }
      current++;
    }

    int remainder = (1000000000 - cycleStart!) % cyclePeriod;
    grid = seen[cycleStart];
    for (int i = 0; i < remainder; i++) {
      cycle(grid);
    }
    return load(grid);
  }

  int load(Grid<String> g) =>
      g.locationsWhere((c) => c == 'O').map((l) => g.height - l.yInt).sum;

  void cycle(Grid<String> g) {
    for (final d in [Vec2.north, Vec2.west, Vec2.south, Vec2.east]) {
      tilt(g, d);
    }
  }

  void tilt(Grid<String> g, Vec2 dir) {
    // Get the locations of all rocks and sort them by x or y component
    // increasing in the reverse direction given. This assumes unit orthongonal
    // directions.
    final rocks = g.locationsWhere((c) => c == 'O').sortedByCompare(
        (l) => l.xInt * dir.xInt + l.yInt * dir.yInt, (a, b) => b - a);
    for (final r in rocks) {
      var next = r + dir;
      while (g.validCell(next) && g.cell(next) == '.') {
        next += dir;
      }
      next -= dir;
      if (g.validCell(next) && g.cell(next) == '.') {
        g.setCell(r, '.');
        g.setCell(next, 'O');
      }
    }
  }
}
