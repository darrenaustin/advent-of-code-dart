// https://adventofcode.com/2021/day/9

import 'package:aoc/aoc.dart';
import 'package:aoc/util/collection.dart';
import 'package:aoc/util/comparison.dart';
import 'package:aoc/util/grid2.dart';
import 'package:aoc/util/string.dart';
import 'package:aoc/util/vec.dart';
import 'package:collection/collection.dart';

main() => Day09().solve();

class Day09 extends AdventDay {
  Day09() : super(2021, 9, name: 'Smoke Basin');

  @override
  dynamic part1(String input) {
    final grid = parseGrid(input);
    return grid
        .locations()
        .map((p) => lowPoint(grid, p) ? grid.cell(p) + 1 : 0)
        .sum;
  }

  @override
  dynamic part2(String input) {
    final grid = parseGrid(input);
    return grid
        .locations()
        .map((p) => lowPoint(grid, p) ? basinSizeFor(grid, p) : null)
        .whereNotNull()
        .sorted(numMaxComparator)
        .take(3)
        .product;
  }

  bool lowPoint(Grid<int> grid, Vec2 p) {
    final n = grid.cell(p);
    return grid.neighbors(p, Vec2.orthogonalDirs).every((e) => n < e);
  }

  int basinSizeFor(Grid<int> grid, Vec2 p) {
    final locs = <Vec2>{};
    final edges = [p];
    while (edges.isNotEmpty) {
      final edge = edges.removeLast();
      locs.add(edge);
      edges.addAll(Vec2.orthogonalDirs.map((offset) => edge + offset).where(
          (newEdge) =>
              grid.validCell(newEdge) &&
              grid.cell(newEdge) != 9 &&
              !locs.contains(newEdge)));
    }
    return locs.length;
  }

  Grid<int> parseGrid(String input) {
    return Grid.from(
        input.lines.map((row) => row.chars.map(int.parse).toList()).toList(),
        0);
  }
}
