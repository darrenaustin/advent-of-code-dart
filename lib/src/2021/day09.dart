// https://adventofcode.com/2021/day/9

import 'package:advent_of_code_dart/src/util/collection.dart';
import 'package:advent_of_code_dart/src/util/grid2.dart';
import 'package:advent_of_code_dart/src/util/vec2.dart';

import '../../day.dart';

class Day09 extends AdventDay {
  Day09() : super(2021, 9, solution1: 541, solution2: 847504);

  @override
  dynamic part1() {
    final grid = inputGrid();
    int sumRisk = 0;
    for (int y = 0; y < grid.height; y++) {
      for (int x = 0; x < grid.width; x++) {
        final p = Vector.int(x, y);
        if (lowPoint(grid, p)) {
          sumRisk += (grid.cell(p) + 1);
        }
      }
    }
    return sumRisk;
  }

  @override
  dynamic part2() {
    final grid = inputGrid();
    final basinSize = <int>[];
    for (int y = 0; y < grid.height; y++) {
      for (int x = 0; x < grid.width; x++) {
        final p = Vector.int(x, y);
        if (lowPoint(grid, p)) {
          basinSize.add(basinSizeFor(grid, p));
        }
      }
    }
    basinSize.sort((a, b) => b.compareTo(a));
    return basinSize.take(3).product();
  }

  bool lowPoint(Grid<int> grid, Vector p) {
    final n = grid.cell(p);
    return grid.orthogonalNeighbors(p).every((e) => n < e);
  }

  int basinSizeFor(Grid<int> grid, Vector p) {
    final locs = <Vector>{};
    final edges = [p];
    while (edges.isNotEmpty) {
      final edge = edges.removeLast();
      locs.add(edge);
      edges.addAll(Grid.orthogonalNeighborOffsets
        .map((offset) => edge + offset)
        .where((newEdge) => grid.validCell(newEdge)
          && grid.cell(newEdge) != 9
          && !locs.contains(newEdge)));
    }
    return locs.length;
  }

  Grid<int> inputGrid() {
    final List<List<int>> nums = inputDataLines()
      .map((l) => l.split('')
        .map((n) => int.parse(n)).toList()
       ).toList();
    final Grid<int> grid = Grid(nums[0].length, nums.length, 0);
    for (int y = 0; y < grid.height; y++) {
      for (int x = 0; x < grid.width; x++) {
        grid.setCell(Vector.int(x, y), nums[y][x]);
      }
    }
    return grid;
  }
}
