// https://adventofcode.com/2022/day/9

import '../../day.dart';
import '../util/grid.dart';
import '../util/math.dart';

class Day09 extends AdventDay {
  Day09() : super(2022, 9, solution1: 6236, solution2: 2449);

  @override
  dynamic part1() {
    final space = RopeSpace(2);
    for (final line in inputDataLines()) {
      final dir = dirs[line[0]]!;
      final amount = int.parse(line.substring(2));
      space.moveHead(dir, amount);
    }
    return space.numTailVisited();
  }

  @override
  dynamic part2() {
    final space = RopeSpace(10);
    for (final line in inputDataLines()) {
      final dir = dirs[line[0]]!;
      final amount = int.parse(line.substring(2));
      space.moveHead(dir, amount);
    }
    return space.numTailVisited();
  }

  static final Map<String, Loc> dirs = {
    'R' : Loc.right,
    'L' : Loc.left,
    'U' : Loc.up,
    'D' : Loc.down,
  };
}

class RopeSpace {
  RopeSpace(int knots) :
    _grid = SparseGrid<String>(defaultValue: '.'),
    _rope = List.generate(knots, (_) => Loc.zero)
  {
    _grid.setCell(_rope.last, '#');
  }

  final SparseGrid<String> _grid;
  final List<Loc> _rope;

  int numTailVisited() {
    return _grid.numSetCellsWhere((c) => c == '#');
  }

  void moveHead(Loc dir, int amount) {
    for (int i = 0; i < amount; i++) {
      _rope[0] += dir;
      for (int k = 1; k < _rope.length; k++) {
        final Loc leader = _rope[k - 1];
        if (!Loc.cardinalDirs.any((l) => (leader + l) == _rope[k])) {
            // Not in any of the surrounding spaces of the leader, so
            // move the knot in the direction of the leader.
            _rope[k] += Loc(sign(leader.x - _rope[k].x), sign(leader.y - _rope[k].y));
        }
      }
      _grid.setCell(_rope.last, '#');
    }
  }
}
