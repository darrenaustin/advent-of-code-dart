// https://adventofcode.com/2015/day/3

import '../../day.dart';
import '../util/grid.dart';

class Day03 extends AdventDay {
  Day03() : super(2015, 3, solution1: 2592, solution2: 2360);

  @override
  dynamic part1() {
    final SparseGrid<int> grid = SparseGrid<int>(defaultValue: 0);
    Loc location = Loc.zero;
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
    Loc santa = Loc.zero;
    Loc robotSanta = Loc.zero;
    grid.setCell(santa, 2);
    bool santaTurn = true;

    for (final String d in inputDirections()) {
      late final Loc presentDropped;
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

  static const Map<String, Loc> _directionOffset = <String, Loc>{
    '^': Loc( 0,  1),
    '>': Loc( 1,  0),
    'v': Loc( 0, -1),
    '<': Loc(-1,  0),
  };
}
