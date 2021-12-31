// https://adventofcode.com/2021/day/20

import 'package:advent_of_code_dart/src/util/grid.dart';

import '../../day.dart';

class Day20 extends AdventDay {
  Day20() : super(2021, 20, solution1: 5349, solution2: 15806);

  @override
  dynamic part1() {
    final inputLines = inputDataLines();
    final algo = inputLines.first.split('').map((s) => s == '#' ? 1 : 0).toList();

    var grid = Grid<int>(inputLines[1].length, inputLines.length - 1, 0);
    int y = 0;
    for (final line in inputLines.skip(1)) {
      for (int x = 0; x < line.length; x++) {
        grid.setCell(Loc(x, y), line[x] == '#' ? 1 : 0);
      }
      y++;
    }

    grid = _enhance(algo, grid, 0);
    grid = _enhance(algo, grid, algo[0]);
    return grid.cellsWhere((l) => l == 1).length;
  }

  @override
  dynamic part2() {
    final inputLines = inputDataLines();
    final algo = inputLines.first.split('').map((s) => s == '#' ? 1 : 0).toList();

    var grid = Grid<int>(inputLines[1].length, inputLines.length - 1, 0);
    int y = 0;
    for (final line in inputLines.skip(1)) {
      for (int x = 0; x < line.length; x++) {
        grid.setCell(Loc(x, y), line[x] == '#' ? 1 : 0);
      }
      y++;
    }

    grid = _enhance(algo, grid, 0);
    for (int i = 0; i < 49; i++) {
      grid = _enhance(algo, grid, i.isEven ? algo.first : algo.last);
    }
    return grid.cellsWhere((l) => l == 1).length;
  }

  static final _areaOffsets = [
    Loc(-1, -1), Loc(0, -1), Loc(1, -1),
    Loc(-1, 0), Loc(0, 0), Loc(1, 0),
    Loc(-1, 1), Loc(0, 1), Loc(1, 1),
  ].map((o) => o + Loc(-2, -2));
  Grid<int> _enhance(List<int> algo, Grid<int>grid, int defaultValue) {
    final newGrid = Grid<int>(grid.width + 4, grid.height + 4, 0);
    for (int y = 0; y < newGrid.height; y++) {
      for (int x = 0; x < newGrid.width; x++) {
        final center = Loc(x, y);
        final areaValues = _areaOffsets.map((o) {
          final l = o + center;
          return grid.validCell(l) ? grid.cell(l) : defaultValue;
        });
        final index = areaValues.reduce((v, e) => (v << 1) | e);
        newGrid.setCell(center, algo[index]);
      }
    }
    return newGrid;
  }
}
