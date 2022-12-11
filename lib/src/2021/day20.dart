// https://adventofcode.com/2021/day/20

import '../../day.dart';
import '../util/grid2.dart';
import '../util/vec2.dart';

class Day20 extends AdventDay {
  Day20() : super(2021, 20, solution1: 5349, solution2: 15806);

  @override
  dynamic part1() {
    final inputLines = inputDataLines();
    final algo = inputAlgorithm(inputLines.first);
    var grid = inputGrid(inputLines);

    return _enhance(algo: algo, grid: grid, numTimes: 2)
      .cellsWhere((l) => l == 1)
      .length;
  }

  @override
  dynamic part2() {
    final inputLines = inputDataLines();
    final algo = inputAlgorithm(inputLines.first);
    final grid = inputGrid(inputLines);

    return _enhance(algo: algo, grid: grid, numTimes: 50)
      .cellsWhere((l) => l == 1)
      .length;
  }

  List<int> inputAlgorithm(String s) =>
    s.split('').map((s) => s == '#' ? 1 : 0).toList();

  Grid<int> inputGrid(List<String> inputLines) {
    final grid = Grid<int>(inputLines[1].length, inputLines.length - 1, 0);
    int y = 0;
    for (final line in inputLines.skip(1)) {
      for (int x = 0; x < line.length; x++) {
        grid.setCell(Vec2.int(x, y), line[x] == '#' ? 1 : 0);
      }
      y++;
    }
    return grid;
  }

  static final _areaOffsets =
    Vec2.cardinalDirs.map((o) => o + Vec2.int(-2, -2));

  Grid<int> _enhance({
    required List<int> algo,
    required Grid<int> grid,
    int outerValue = 0,
    int numTimes = 1,
  }) {
    for (int i = 0; i < numTimes; i++) {
      final newGrid = Grid<int>(grid.width + 4, grid.height + 4, 0);
      for (int y = 0; y < newGrid.height; y++) {
        for (int x = 0; x < newGrid.width; x++) {
          final center = Vec2.int(x, y);
          final areaValues = _areaOffsets.map((o) {
            final l = o + center;
            return grid.validCell(l) ? grid.cell(l) : outerValue;
          });
          final index = areaValues.reduce((v, e) => (v << 1) | e);
          newGrid.setCell(center, algo[index]);
        }
      }
      grid = newGrid;
      outerValue = outerValue == 0 ? algo.first : algo.last;
    }
    return grid;
  }
}
