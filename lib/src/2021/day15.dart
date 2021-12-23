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

  Grid<int> inputGrid() {
    final lines = inputDataLines().map((l) =>
        l.split('').map((n) => int.parse(n)).toList()).toList();
    final grid = Grid<int>(lines.first.length, lines.length, 0);
    for (int r = 0; r < grid.height; r++) {
      for (int c = 0; c < grid.width; c++) {
        grid.setCell(Loc(c, r), lines[r][c]);
      }
    }
    return grid;
  }

  double? _lowestRisk(Grid<int> grid) {
    final start = Loc(0, 0);
    final goal = Loc(grid.width - 1, grid.height - 1);
    return aStarLowestCost<Loc>(
      start: start,
      goal: goal,
      estimatedDistance: (l) => (l.x + l.y).toDouble(),
      costTo: (from, to) => grid.cell(to).toDouble(),
      neighborsOf: (loc) =>
        grid.neighborLocations(loc, Grid.orthogonalNeighborOffsets),
    );
    // return dijkstraLowestCost<Loc>(
    //   start: start,
    //   goal: goal,
    //   costTo: (from, to) => grid.cell(to).toDouble(),
    //   neighborsOf: (loc) =>
    //       grid.neighborLocations(loc, Grid.orthogonalNeighborOffsets),
    // );
  }

  Grid<int> _expandGrid(Grid<int> source) {
    final grid = Grid<int>(source.width * 5, source.height * 5, 0);
    for (int gridX = 0; gridX < 5; gridX++) {
      for (int gridY = 0; gridY < 5; gridY++) {
        final riskIncrease = gridX + gridY;
        final gridOrigin = Loc(gridX * source.width, gridY * source.height);
        for (int x = 0; x < source.width; x++) {
          for (int y = 0; y < source.height; y++) {
            final cellLoc = Loc(x, y);
            final risk = (source.cell(cellLoc) + riskIncrease - 1) % 9 + 1;
            grid.setCell(gridOrigin + cellLoc, risk);
          }
        }
      }
    }
    return grid;
  }
}
