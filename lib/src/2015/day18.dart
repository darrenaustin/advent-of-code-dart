// https://adventofcode.com/2015/day/18

import '../../day.dart';
import '../util/grid2.dart';
import '../util/vec2.dart';

class Day18 extends AdventDay {
  Day18() : super(2015, 18, solution1: 821, solution2: 886);

  @override
  dynamic part1() {
    Grid<String> grid = inputGrid();
    for (int i = 0; i < 100; i++) {
      grid = animate(grid);
    }
    return grid.cellsWhere(lightOn).length;
  }

  @override
  dynamic part2() {
    Grid<String> grid = inputGrid();
    turnCornersOn(grid);
    for (int i = 0; i < 100; i++) {
      grid = animate(grid);
      turnCornersOn(grid);
    }
    return grid.cellsWhere(lightOn).length;
  }

  Grid<String> inputGrid() {
    final List<String> lines = inputDataLines();
    final Grid<String> grid = Grid<String>(lines[0].length, lines.length, '.');
    for (int y = 0; y < grid.height; y++) {
      for (int x = 0; x < grid.width; x++) {
        grid.setCell(Vector.int(x, y), lines[y][x]);
      }
    }
    return grid;
  }

  static bool lightOn(String l) => l == '#';

  Grid<String> animate(Grid<String> grid) {
    final Grid<String> nextGrid = Grid<String>(grid.width, grid.height, grid.defaultValue);
    for (int y = 0; y < grid.height; y++) {
      for (int x = 0; x < grid.width; x++) {
        final Vector p = Vector.int(x, y);
        final bool on = lightOn(grid.cell(p));
        final int neighborsOn = grid.neighbors(p).where(lightOn).length;
        if (on && (neighborsOn == 2 || neighborsOn == 3)) {
          nextGrid.setCell(p, '#');
        } else if (neighborsOn == 3) {
          nextGrid.setCell(p, '#');
        }
      }
    }
    return nextGrid;
  }

  void turnCornersOn(Grid<String> grid) {
    grid.setCell(Vector.zero, '#');
    grid.setCell(Vector(grid.width - 1, 0), '#');
    grid.setCell(Vector(0, grid.height - 1), '#');
    grid.setCell(Vector(grid.width - 1, grid.height - 1), '#');
  }
}
