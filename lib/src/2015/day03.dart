// https://adventofcode.com/2015/day/3

import 'package:aoc/aoc.dart';
import 'package:aoc/util/sparse_grid.dart';
import 'package:aoc/util/vec2.dart';

class Day03 extends AdventDay {
  Day03() : super(2015, 3, solution1: 2592, solution2: 2360);

  @override
  dynamic part1() {
    final SparseGrid<int> grid = SparseGrid<int>(defaultValue: 0);
    Vec2 location = Vec2.zero;
    grid.setCell(location, 1);

    for (final String d in inputDirections()) {
      location += _directionOffset[d]!;
      grid.setCell(location, grid.cell(location) + 1);
    }

    return grid.numSetCells();
  }

  @override
  dynamic part2() {
    final SparseGrid<int> grid = SparseGrid<int>(defaultValue: 0);
    Vec2 santa = Vec2.zero;
    Vec2 robotSanta = Vec2.zero;
    grid.setCell(santa, 2);
    bool santaTurn = true;

    for (final String d in inputDirections()) {
      late final Vec2 presentDropped;
      if (santaTurn) {
        santa += _directionOffset[d]!;
        presentDropped = santa;
      } else {
        robotSanta += _directionOffset[d]!;
        presentDropped = robotSanta;
      }
      grid.setCell(presentDropped, grid.cell(presentDropped) + 1);
      santaTurn = !santaTurn;
    }
    return grid.numSetCells();
  }

  Iterable<String> inputDirections() {
    return inputData().trim().split('');
  }

  static const Map<String, Vec2> _directionOffset = <String, Vec2>{
    '^': Vec2.up,
    '>': Vec2.right,
    'v': Vec2.down,
    '<': Vec2.left,
  };
}
