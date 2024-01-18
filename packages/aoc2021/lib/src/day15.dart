// https://adventofcode.com/2021/day/15

import 'package:aoc/aoc.dart';
import 'package:aoc/util/grid2.dart';
import 'package:aoc/util/pathfinding.dart';
import 'package:aoc/util/string.dart';
import 'package:aoc/util/vec.dart';

main() => Day15().solve();

class Day15 extends AdventDay {
  Day15() : super(2021, 15, name: 'Chiton');

  @override
  dynamic part1(String input) => _lowestRisk(parseGrid(input));

  @override
  dynamic part2(String input) => _lowestRisk(_expandGrid(parseGrid(input)));

  Grid<int> parseGrid(String input) => Grid<int>.from(
      input.lines
          .map((l) => l.split('').map((n) => int.parse(n)).toList())
          .toList(),
      0);

  double? _lowestRisk(Grid<int> grid) {
    final start = Vec.zero;
    final goal = Vec.int(grid.width - 1, grid.height - 1);
    return aStarLowestCost<Vec>(
      start: start,
      goal: goal,
      estimatedDistance: (p) => (p.distanceTo(goal)),
      costTo: (from, to) => grid.cell(to).toDouble(),
      neighborsOf: (i) => grid.neighborLocations(i, Vec.orthogonalDirs),
    );
  }

  Grid<int> _expandGrid(Grid<int> source) {
    final grid = Grid<int>(source.width * 5, source.height * 5, 0);
    for (int gridX = 0; gridX < 5; gridX++) {
      for (int gridY = 0; gridY < 5; gridY++) {
        final riskIncrease = gridX + gridY;
        final gridOrigin = Vec.int(gridX * source.width, gridY * source.height);
        for (int x = 0; x < source.width; x++) {
          for (int y = 0; y < source.height; y++) {
            final cellLoc = Vec.int(x, y);
            final risk = (source.cell(cellLoc) + riskIncrease - 1) % 9 + 1;
            grid.setCell(gridOrigin + cellLoc, risk);
          }
        }
      }
    }
    return grid;
  }
}
