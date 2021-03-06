// https://adventofcode.com/2021/day/11

import 'package:advent_of_code_dart/src/util/grid.dart';

import '../../day.dart';

class Day11 extends AdventDay {
  Day11() : super(2021, 11, solution1: 1562, solution2: 268);

  @override
  dynamic part1() {
    final grid = inputGrid();
    int numFlashes = 0;
    for (int i = 0; i < 100; i++) {
      numFlashes += stepGrid(grid).length;
    }
    return numFlashes;
  }

  @override
  dynamic part2() {
    final grid = inputGrid();
    int step = 0;
    while (!grid.cells().every((v) => v == 0)) {
      stepGrid(grid);
      step++;
    }
    return step;
  }

  Iterable<Loc> stepGrid(Grid<int> grid) {
    grid.updateCells((v) => v + 1);
    final flashes = <Loc>{};
    final needFlashes = grid.locationsWhere((v) => v > 9).toList();
    while (needFlashes.isNotEmpty) {
      final flash = needFlashes.removeLast();
      if (!flashes.contains(flash)) {
        flashes.add(flash);
        for (final neighbor in grid.neighborLocations(flash)) {
          final updatedEnergy = grid.cell(neighbor) + 1;
          grid.setCell(neighbor, updatedEnergy);
          if (updatedEnergy > 9 && !flashes.contains(neighbor)) {
            needFlashes.add(neighbor);
          }
        }
      }
    }
    for (final flash in flashes) {
      grid.setCell(flash, 0);
    }
    return flashes;
  }

  Grid<int> inputGrid() {
    final List<List<int>> nums = inputDataLines()
        .map((l) => l.split('')
        .map((n) => int.parse(n)).toList()
    ).toList();
    final Grid<int> grid = Grid(nums[0].length, nums.length, 0);
    for (int y = 0; y < grid.height; y++) {
      for (int x = 0; x < grid.width; x++) {
        grid.setCell(Loc(x, y), nums[y][x]);
      }
    }
    return grid;
  }
}
