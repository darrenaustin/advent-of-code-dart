// https://adventofcode.com/2023/day/13

import 'package:aoc/aoc.dart';
import 'package:aoc/util/grid2.dart';
import 'package:aoc/util/vec2.dart';
import 'package:collection/collection.dart';

main() => Day13().solve();

class Day13 extends AdventDay {
  Day13() : super(2023, 13, name: 'Point of Incidence');

  @override
  dynamic part1(String input) => parseGrids(input).map(findMirrorValue).sum;

  @override
  dynamic part2(String input) =>
      parseGrids(input).map((g) => findSmudgeMirrorValue(g)).sum;

  List<Grid<String>> parseGrids(String input) =>
      input.split('\n\n').map(Grid.fromString).toList();

  int findMirrorValue(Grid<String> grid) {
    final vMirror = findVertMirrorCol(grid);
    if (vMirror != null) {
      return vMirror;
    }
    final hMirror = findHorizMirrorRow(grid);
    if (hMirror != null) {
      return 100 * hMirror;
    }
    throw Exception('No mirror found:\n$grid');
  }

  int findSmudgeMirrorValue(Grid<String> grid) {
    final vertMirror = findVertMirrorCol(grid);
    final horizMirror = findHorizMirrorRow(grid);
    for (final l in grid.locations()) {
      final origValue = grid.cell(l);
      grid.setCell(l, origValue == '.' ? '#' : '.');
      final vMirror = findVertMirrorCol(grid, vertMirror);
      if (vMirror != null) {
        return vMirror;
      }
      final hMirror = findHorizMirrorRow(grid, horizMirror);
      if (hMirror != null) {
        return 100 * hMirror;
      }
      grid.setCell(l, origValue);
    }
    throw Exception(
        'No smudged mirror found:\n$grid\n v = $vertMirror, h = $horizMirror');
  }

  int? findVertMirrorCol(Grid<String> grid, [int? notCol]) {
    bool vertMirrorAt(int col) {
      if (col == notCol) {
        return false;
      }
      for (int tx = 0; tx <= col; tx++) {
        int mirrorX = col + col - tx - 1;
        if (mirrorX >= grid.width) {
          continue;
        }
        for (int y = 0; y < grid.height; y++) {
          if (grid.cell(Vec2.int(tx, y)) != grid.cell(Vec2.int(mirrorX, y))) {
            return false;
          }
        }
      }
      return true;
    }

    for (int x = 1; x < grid.width; x++) {
      if (vertMirrorAt(x)) {
        return x;
      }
    }
    return null;
  }

  int? findHorizMirrorRow(Grid<String> grid, [int? notRow]) {
    bool horizMirrorAt(int row) {
      if (row == notRow) {
        return false;
      }
      for (int ty = 0; ty <= row; ty++) {
        int mirrorY = row + row - ty - 1;
        if (mirrorY >= grid.height) {
          continue;
        }
        for (int x = 0; x < grid.width; x++) {
          if (grid.cell(Vec2.int(x, ty)) != grid.cell(Vec2.int(x, mirrorY))) {
            return false;
          }
        }
      }
      return true;
    }

    for (int y = 1; y < grid.height; y++) {
      if (horizMirrorAt(y)) {
        return y;
      }
    }
    return null;
  }
}
