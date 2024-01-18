// https://adventofcode.com/2023/day/14

import 'package:aoc/aoc.dart';
import 'package:aoc/util/grid.dart';
import 'package:aoc/util/vec.dart';
import 'package:collection/collection.dart';

main() => Day14().solve();

class Day14 extends AdventDay {
  Day14() : super(2023, 14, name: 'Parabolic Reflector Dish');

  @override
  dynamic part1(String input) {
    Grid<String> grid = Grid.parse(input);
    tilt(grid, Vec.up);
    return load(grid);
  }

  @override
  dynamic part2(String input) {
    Grid<String> grid = Grid.parse(input);
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
      g.locationsWhereValue((c) => c == 'O').map((l) => g.height - l.yInt).sum;

  void cycle(Grid<String> g) {
    for (final d in [Vec.north, Vec.west, Vec.south, Vec.east]) {
      tilt(g, d);
    }
  }

  void tilt(Grid<String> g, Vec dir) {
    // Get the locations of all rocks and sort them by x or y component
    // increasing in the reverse direction given. This assumes unit orthongonal
    // directions.
    final rocks = g.locationsWhereValue((c) => c == 'O').sortedByCompare(
        (l) => l.x * dir.x + l.y * dir.y, (a, b) => (b - a).toInt());
    for (final r in rocks) {
      var next = r + dir;
      while (g.validLocation(next) && g.value(next) == '.') {
        next += dir;
      }
      next -= dir;
      if (g.validLocation(next) && g.value(next) == '.') {
        g.setValue(r, '.');
        g.setValue(next, 'O');
      }
    }
  }
}
