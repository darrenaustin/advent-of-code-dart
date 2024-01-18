// https://adventofcode.com/2017/day/3

import 'package:aoc/aoc.dart';
import 'package:aoc/util/sparse_grid.dart';
import 'package:aoc/util/vec2.dart';
import 'package:collection/collection.dart';

main() => Day03().solve();

class Day03 extends AdventDay {
  Day03() : super(2017, 3, name: 'Spiral Memory');

  @override
  dynamic part1(String input) => spiralPositions()
      .skip(int.parse(input) - 1)
      .first
      .manhattanDistanceTo(Vec2.zero);

  @override
  dynamic part2(String input) {
    final goal = int.parse(input);
    final grid = SparseGrid<int>(
        defaultValue: 0, cellPrintWidth: input.trim().length + 1);
    final spiral = spiralPositions().skip(1).iterator;
    int n = 1;
    grid.setCell(Vec2.zero, n);
    while (n <= goal && spiral.moveNext()) {
      final pos = spiral.current;
      n = Vec2.aroundDirs
          .map((d) => pos + d)
          .where((p) => grid.isSet(p))
          .map((p) => grid.cell(p))
          .sum;
      grid.setCell(pos, n);
    }
    return n;
  }

  Iterable<Vec2> spiralPositions() sync* {
    final dirs = spiralDirs();
    Vec2 pos = dirs.first;
    yield pos;

    for (final dir in dirs.skip(1)) {
      pos += dir;
      yield pos;
    }
  }

  Iterable<Vec2> spiralDirs() sync* {
    int ring = 0;
    yield Vec2.zero;
    while (true) {
      ring += 2;

      yield Vec2.right;
      yield* List.filled(ring - 1, Vec2.up);
      yield* List.filled(ring, Vec2.left);
      yield* List.filled(ring, Vec2.down);
      yield* List.filled(ring, Vec2.right);
    }
  }
}
