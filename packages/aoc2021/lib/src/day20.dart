// https://adventofcode.com/2021/day/20

import 'package:aoc/aoc.dart';
import 'package:aoc/util/grid2.dart';
import 'package:aoc/util/string.dart';
import 'package:aoc/util/vec.dart';

main() => Day20().solve();

class Day20 extends AdventDay {
  Day20() : super(2021, 20, name: 'Trench Map');

  @override
  dynamic part1(String input) => _litAfterEnhancement(input, 2);

  @override
  dynamic part2(String input) => _litAfterEnhancement(input, 50);

  static int _charToPixel(String c) => c == '#' ? 1 : 0;

  List<int> parseAlgorithm(String line) =>
      line.split('').map(_charToPixel).toList();

  Grid<int> parseGrid(List<String> lines) {
    final pixels =
        lines.map((line) => line.chars.map(_charToPixel).toList()).toList();
    return Grid.from(pixels, 0);
  }

  static final _areaOffsets =
      Vec2.cardinalDirs.map((o) => o + Vec2.int(-2, -2));

  int _litAfterEnhancement(String input, int numEnhancements) {
    final inputLines = input.lines;
    final algo = parseAlgorithm(inputLines.first);
    final grid = parseGrid(inputLines.sublist(2));

    return _enhance(algo: algo, grid: grid, numTimes: numEnhancements)
        .cellsWhere((l) => l == 1)
        .length;
  }

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
      // Because the grid is infinite if this iteration the lights outside
      // the current grid was off, then each of the next iteration's outside
      // cells will map to the 0th entry in the algorithm. Otherwise they will
      // all be turned on and thence map to the last entry.
      outerValue = outerValue == 0 ? algo.first : algo.last;
    }
    return grid;
  }
}
