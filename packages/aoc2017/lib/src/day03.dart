// https://adventofcode.com/2017/day/3

import 'package:aoc/aoc.dart';
import 'package:aoc/util/sparse_grid.dart';
import 'package:aoc/util/vec.dart';
import 'package:collection/collection.dart';

main() => Day03().solve();

class Day03 extends AdventDay {
  Day03() : super(2017, 3, name: 'Spiral Memory');

  @override
  dynamic part1(String input) => spiralPositions()
      .skip(int.parse(input) - 1)
      .first
      .manhattanDistanceTo(Vec.zero);

  @override
  dynamic part2(String input) {
    final goal = int.parse(input);
    final grid = SparseGrid<int>(
        defaultValue: 0, cellPrintWidth: input.trim().length + 1);
    final spiral = spiralPositions().skip(1).iterator;
    int n = 1;
    grid.setCell(Vec.zero, n);
    while (n <= goal && spiral.moveNext()) {
      final pos = spiral.current;
      n = Vec.aroundDirs
          .map((d) => pos + d)
          .where((p) => grid.isSet(p))
          .map((p) => grid.cell(p))
          .sum;
      grid.setCell(pos, n);
    }
    return n;
  }

  Iterable<Vec> spiralPositions() sync* {
    final dirs = spiralDirs();
    Vec pos = dirs.first;
    yield pos;

    for (final dir in dirs.skip(1)) {
      pos += dir;
      yield pos;
    }
  }

  Iterable<Vec> spiralDirs() sync* {
    int ring = 0;
    yield Vec.zero;
    while (true) {
      ring += 2;

      yield Vec.right;
      yield* List.filled(ring - 1, Vec.up);
      yield* List.filled(ring, Vec.left);
      yield* List.filled(ring, Vec.down);
      yield* List.filled(ring, Vec.right);
    }
  }
}
