// https://adventofcode.com/2015/day/3

import '../../day.dart';
import '../util/grid2.dart';
import '../util/vec2.dart';

class Day03 extends AdventDay {
  Day03() : super(2015, 3, solution1: 2592, solution2: 2360);

  @override
  dynamic part1() {
    final SparseGrid<int> grid = SparseGrid<int>(defaultValue: 0);
    Vector location = Vector.zero;
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
    Vector santa = Vector.zero;
    Vector robotSanta = Vector.zero;
    grid.setCell(santa, 2);
    bool santaTurn = true;

    for (final String d in inputDirections()) {
      late final Vector presentDropped;
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

  static const Map<String, Vector> _directionOffset = <String, Vector>{
    '^': Vector( 0,  1),
    '>': Vector( 1,  0),
    'v': Vector( 0, -1),
    '<': Vector(-1,  0),
  };
}
