// https://adventofcode.com/2022/day/8

import 'package:aoc/aoc.dart';

main() => Day08().solve();

class Day08 extends AdventDay {
  Day08() : super(
    2022, 8, name: '',
  );

  @override
  dynamic part1(String input) => 'Need to migrate';

  @override
  dynamic part2(String input) => 'Need to migrate';
}

// https://adventofcode.com/2022/day/8
// 
// import 'package:aoc/aoc.dart';
// import 'package:aoc/util/collection.dart';
// import 'package:aoc/util/grid2.dart';
// import 'package:aoc/util/vec2.dart';
// import 'package:collection/collection.dart';
// 
// class Day08 extends AdventDay {
//   Day08() : super(2022, 8, solution1: 1794, solution2: 199272);
// 
//   @override
//   dynamic part1() {
//     final grid = inputGrid();
// 
//     final Set<Vec2> visible = {};
//     for (int col = 0; col < grid.width; col++) {
//       visible.addAll(seenInDirection(grid, Vec2.int(col, 0), Vec2.down));
//       visible.addAll(seenInDirection(grid, Vec2.int(col, grid.height -1), Vec2.up));
//     }
//     for (int row = 0; row < grid.height; row++) {
//       visible.addAll(seenInDirection(grid, Vec2.int(0, row), Vec2.right));
//       visible.addAll(seenInDirection(grid, Vec2.int(grid.width - 1, row), Vec2.left));
//     }
//     return visible.length;
//   }
// 
//   @override
//   dynamic part2() {
//     final grid = inputGrid();
//     int score(Vec2 tree) => Vec2.orthogonalDirs
//       .map((d) => numSeenFromTree(grid, tree, d))
//       .product;
//     return grid.locations().map(score).max;
//   }
// 
//   Iterable<Vec2> seenInDirection(Grid<int> grid, Vec2 starting, Vec2 dir) {
//     final List<Vec2> seen = [starting];
//     Vec2 max = starting;
//     Vec2 current = starting + dir;
//     while (grid.validCell(current)) {
//       if (grid.cell(max) < grid.cell(current)) {
//         seen.add(current);
//         max = current;
//       }
//       current = current + dir;
//     }
//     return seen;
//   }
// 
//   int numSeenFromTree(Grid<int> grid, Vec2 tree, Vec2 dir) {
//     int seen = 0;
//     int treeHeight = grid.cell(tree);
//     Vec2 current = tree + dir;
//     while (grid.validCell(current)) {
//       seen += 1;
//       if (grid.cell(current) >= treeHeight) {
//         return seen;
//       }
//       current = current + dir;
//     }
//     return seen;
//   }
// 
//   Grid<int> inputGrid() {
//     final data = inputDataLines()
//       .map((l) => l
//         .split('')
//         .map(int.parse)
//         .toList())
//       .toList();
//     return Grid<int>.from(data, 0);
//   }
// }
// 