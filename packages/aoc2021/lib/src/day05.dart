// https://adventofcode.com/2021/day/5

import 'package:aoc/aoc.dart';
import 'package:aoc/util/collection.dart';
import 'package:aoc/util/grid2.dart';
import 'package:aoc/util/vec2.dart';

class Day05 extends AdventDay {
  Day05() : super(2021, 5, solution1: 4826, solution2: 16793);

  @override
  dynamic part1() {
    final grid = Grid<int>(1000, 1000, 0);
    for (final line in inputLines().where(_orthogonal)) {
      for (final p in line.pointsAlong()) {
        grid.setCell(p, grid.cell(p) + 1);
      }
    }
    return grid.cellsWhere((count) => count >= 2).length;
  }

  @override
  dynamic part2() {
    final grid = Grid<int>(1000, 1000, 0);
    for (final line in inputLines()) {
      for (final p in line.pointsAlong()) {
        grid.setCell(p, grid.cell(p) + 1);
      }
    }
    return grid.cellsWhere((count) => count >= 2).length;
  }

  Iterable<LineSegment> inputLines() {
    return inputDataLines().map((s) {
      final nums = s.split(RegExp(r'\D+')).map((n) => int.parse(n)).toList();
      return LineSegment(nums[0], nums[1], nums[2], nums[3]);
    });
  }
}

bool _orthogonal(LineSegment line) => (line.startX == line.endX || line.startY == line.endY);

class LineSegment {
  LineSegment(this.startX, this.startY, this.endX, this.endY);

  final int startX;
  final int startY;
  final int endX;
  final int endY;

  Iterable<Vec2> pointsAlong() sync* {
    var ys = range(startY, endY + (startY > endY ? -1 : 1)).toList();
    var xs = range(startX, endX + (startX > endX ? -1 : 1)).toList();
    if (ys.length == 1) {
      ys = List<int>.filled(xs.length, ys.first);
    }
    if (xs.length == 1) {
      xs = List<int>.filled(ys.length, xs.first);
    }
    for (int i = 0; i < ys.length; i++) {
      yield Vec2.int(xs[i], ys[i]);
    }
  }

  @override
  String toString() {
    return 'line ($startX, $startY) -> ($endX, $endY)';
  }
}
