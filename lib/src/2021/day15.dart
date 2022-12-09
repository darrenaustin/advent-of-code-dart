// https://adventofcode.com/2021/day/15

import 'package:advent_of_code_dart/src/util/grid.dart';
import 'package:advent_of_code_dart/src/util/pathfinding.dart';

import '../../day.dart';

class Day15 extends AdventDay {
  Day15() : super(2021, 15, solution1: 498, solution2: 2901);

  @override
  dynamic part1() {
    return _lowestRisk(inputGrid());
  }

  @override
  dynamic part2() {
    return _lowestRisk(_expandGrid(inputGrid()));
  }

  IndexedGrid<int> inputGrid() {
    final lines = inputDataLines().map((l) =>
      l.split('').map((n) => int.parse(n)).toList()).toList();
    final grid = IndexedGrid<int>(lines.first.length, lines.length, 0);
    for (int r = 0; r < grid.height; r++) {
      for (int c = 0; c < grid.width; c++) {
        grid[grid.index(c, r)] = lines[r][c];
      }
    }
    return grid;
  }

  double? _lowestRisk(IndexedGrid<int> grid) {
    final start = 0;
    final goal = grid.index(grid.width - 1, grid.height - 1);
    return aStarLowestCost<int>(
      start: start,
      goal: goal,
      estimatedDistance: (i) => (grid.x(i) + grid.y(i)).toDouble(),
      costTo: (from, to) => grid[to].toDouble(),
      neighborsOf: (i) => grid.neighborLocations(i, Loc.orthogonalDirs),
    );
  }

  IndexedGrid<int> _expandGrid(IndexedGrid<int> source) {
    final grid = IndexedGrid<int>(source.width * 5, source.height * 5, 0);
    for (int gridX = 0; gridX < 5; gridX++) {
      for (int gridY = 0; gridY < 5; gridY++) {
        final riskIncrease = gridX + gridY;
        final gridOrigin = Loc(gridX * source.width, gridY * source.height);
        for (int x = 0; x < source.width; x++) {
          for (int y = 0; y < source.height; y++) {
            final cellLoc = Loc(x, y);
            final risk = (source[source.indexOf(cellLoc)] + riskIncrease - 1) % 9 + 1;
            grid[grid.indexOf(gridOrigin + cellLoc)] = risk;
          }
        }
      }
    }
    return grid;
  }
}
