// https://adventofcode.com/2019/day/11

import 'package:aoc/aoc.dart';
import 'package:aoc/util/sparse_grid.dart';
import 'package:aoc/util/vec.dart';

import 'intcode.dart';

main() => Day11().solve();

class Day11 extends AdventDay {
  Day11() : super(2019, 11, name: 'Space Police');

  @override
  dynamic part1(String input) => paintedHull(input, black).numSetCells();

  @override
  dynamic part2(String input) {
    print('\n');
    print(paintedHull(input, white));
    print('\n');

    // Had to manually inspect output above to get answer:
    return 'GARPKZUL';
  }

  static Map<Vec, Vec> rotateLeft = {
    Vec.up: Vec.left,
    Vec.down: Vec.right,
    Vec.left: Vec.down,
    Vec.right: Vec.up,
  };

  static Map<Vec, Vec> rotateRight = {
    Vec.up: Vec.right,
    Vec.down: Vec.left,
    Vec.left: Vec.up,
    Vec.right: Vec.down,
  };

  static const String black = ' ';
  static const String white = '#'; // '#';

  SparseGrid<String> paintedHull(String program, String initialPanelColor) {
    final machine = Intcode.from(program: program);
    final hull = SparseGrid<String>(defaultValue: black);
    Vec location = Vec.zero;
    Vec direction = Vec.up;
    machine.input.add(initialPanelColor == black ? 0 : 1);
    while (!machine.execute()) {
      final paint = machine.output.removeAt(0);
      hull.setCell(location, paint == 0 ? black : white);
      final rotation = machine.output.removeAt(0);
      direction =
          rotation == 0 ? rotateLeft[direction]! : rotateRight[direction]!;
      location += direction;
      machine.input.add(hull.cell(location) == black ? 0 : 1);
    }
    return hull;
  }
}
