// https://adventofcode.com/2021/day/5
import 'package:advent_of_code_dart/src/util/grid2.dart';
import 'package:advent_of_code_dart/src/util/math.dart';
import 'package:advent_of_code_dart/src/util/vec2.dart';

import '../../day.dart';

class Day05 extends AdventDay {
  Day05() : super(2021, 5, solution1: 4826, solution2: 16793);

  @override
  dynamic part1() {
    // TODO: using the SparseGrid is WAY too slow here.
    final grid = SparseGrid<int>(defaultValue: 0);
    for (final line in inputLines()) {
      final step = Vector.int(sign(line.end.x - line.start.x), sign(line.end.y - line.start.y));
      if (step.x != 0 && step.y != 0) {
        continue;
      }
      for (Vector p = line.start; p != line.end; p += step) {
        grid.setCell(p, grid.cell(p) + 1);
      }
      grid.setCell(line.end, grid.cell(line.end) + 1);
    }
    return grid.numSetCellsWhere((count) => count >= 2);
  }

  @override
  dynamic part2() {
    // TODO: using the SparseGrid is WAY too slow here.
    final grid = SparseGrid<int>(defaultValue: 0);
    for (final line in inputLines()) {
      final step = Vector.int(sign(line.end.x - line.start.x), sign(line.end.y - line.start.y));
      for (Vector p = line.start; p != line.end; p += step) {
        grid.setCell(p, grid.cell(p) + 1);
      }
      grid.setCell(line.end, grid.cell(line.end) + 1);
    }
    return grid.numSetCellsWhere((count) => count >= 2);
  }

  Iterable<LineSegment> inputLines() {
    return inputDataLines().map((s) {
      final nums = s.split(RegExp(r'[^\d]+')).map((n) => int.parse(n)).toList();
      return LineSegment(Vector.int(nums[0], nums[1]), Vector.int(nums[2], nums[3]));
    });
  }
}

class LineSegment {
  LineSegment(this.start, this.end);

  final Vector start;
  final Vector end;

  bool orthogonal() {
    return (start.x == end.x || start.y == end.y);
  }
}
