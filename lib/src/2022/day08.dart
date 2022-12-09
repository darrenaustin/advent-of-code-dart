// https://adventofcode.com/2022/day/8

import '../../day.dart';
import '../util/collection.dart';
import '../util/grid.dart';

class Day08 extends AdventDay {
  Day08() : super(2022, 8, solution1: 1794, solution2: 199272);

  @override
  dynamic part1() {
    final grid = inputGrid();

    final Set<Loc> visible = {};
    for (int col = 0; col < grid.width; col++) {
      visible.addAll(seenInDirection(grid, Loc(col, 0), Loc.down));
      visible.addAll(seenInDirection(grid, Loc(col, grid.height -1), Loc.up));
    }
    for (int row = 0; row < grid.height; row++) {
      visible.addAll(seenInDirection(grid, Loc(0, row), Loc.right));
      visible.addAll(seenInDirection(grid, Loc(grid.width - 1, row), Loc.left));
    }
    return visible.length;
  }

  @override
  dynamic part2() {
    final grid = inputGrid();
    int score(Loc tree) => Loc.orthogonalDirs
      .map((d) => numSeenFromTree(grid, tree, d))
      .product();
    return grid.locations().map(score).max();
  }

  Iterable<Loc> seenInDirection(Grid<int> grid, Loc starting, Loc dir) {
    final List<Loc> seen = [starting];
    Loc max = starting;
    Loc current = starting + dir;
    while (grid.validCell(current)) {
      if (grid.cell(max) < grid.cell(current)) {
        seen.add(current);
        max = current;
      }
      current = current + dir;
    }
    return seen;
  }

  int numSeenFromTree(Grid<int> grid, Loc tree, Loc dir) {
    int seen = 0;
    int treeHeight = grid.cell(tree);
    Loc current = tree + dir;
    while (grid.validCell(current)) {
      seen += 1;
      if (grid.cell(current) >= treeHeight) {
        return seen;
      }
      current = current + dir;
    }
    return seen;
  }

  Grid<int> inputGrid() {
    final data = inputDataLines()
      .map((l) => l
        .split('')
        .map(int.parse)
        .toList())
      .toList();
    return Grid<int>.from(data, 0);
  }
}
