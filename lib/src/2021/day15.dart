// https://adventofcode.com/2021/day/15

import '../../day.dart';
import '../util/grid2.dart';
import '../util/pathfinding.dart';
import '../util/vec2.dart';

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
    final lines = inputDataLines()
      .map((l) => l.split('').map((n) => int.parse(n)).toList())
      .toList();
    return Grid<int>.from(lines, 0);
  }

  double? _lowestRisk(Grid<int> grid) {
    final start = Vec2.zero;
    final goal = Vec2.int(grid.width - 1, grid.height - 1);
    return aStarLowestCost<Vec2>(
      start: start,
      goal: goal,
      estimatedDistance: (p) => (p.distanceTo(goal)),
      costTo: (from, to) => grid.cell(to).toDouble(),
      neighborsOf: (i) => grid.neighborLocations(i, Vec2.orthogonalDirs),
    );
  }

  Grid<int> _expandGrid(Grid<int> source) {
    final grid = Grid<int>(source.width * 5, source.height * 5, 0);
    for (int gridX = 0; gridX < 5; gridX++) {
      for (int gridY = 0; gridY < 5; gridY++) {
        final riskIncrease = gridX + gridY;
        final gridOrigin = Vec2.int(gridX * source.width, gridY * source.height);
        for (int x = 0; x < source.width; x++) {
          for (int y = 0; y < source.height; y++) {
            final cellLoc = Vec2.int(x, y);
            final risk = (source.cell(cellLoc) + riskIncrease - 1) % 9 + 1;
            grid.setCell(gridOrigin + cellLoc, risk);
          }
        }
      }
    }
    return grid;
  }
}
