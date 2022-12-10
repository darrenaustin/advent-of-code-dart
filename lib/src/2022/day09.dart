// https://adventofcode.com/2022/day/9

import '../../day.dart';
import '../util/grid.dart';

class Day09 extends AdventDay {
  Day09() : super(2022, 9, solution1: 6236, solution2: 2449);

  @override
  dynamic part1() {
    final rope = Rope(2);
    rope.followInstructions(inputDataLines());
    return rope.numTailVisited();
  }

  @override
  dynamic part2() {
    final rope = Rope(10);
    rope.followInstructions(inputDataLines());
    return rope.numTailVisited();
  }
}

class Rope {
  Rope(int knots) :
    _knot = List.generate(knots, (_) => Loc.zero),
    _tailVisited = <Loc>{Loc.zero};

  final List<Loc> _knot;
  final Set<Loc> _tailVisited;

  int numTailVisited() {
    return _tailVisited.length;
  }

  void followInstructions(List<String> instructions) {
    for (final line in instructions) {
      final dir = dirs[line[0]]!;
      final amount = int.parse(line.substring(2));
      moveHead(dir, amount);
    }
  }

  void moveHead(Loc dir, int amount) {
    for (int i = 0; i < amount; i++) {
      _knot[0] += dir;
      for (int k = 1; k < _knot.length; k++) {
        final Loc leader = _knot[k - 1];
        if (!Loc.cardinalDirs.any((l) => (leader + l) == _knot[k])) {
            // Not in any of the surrounding spaces of the leader, so
            // move the knot in the direction of the leader.
            _knot[k] += Loc(
              leader.x.compareTo(_knot[k].x),
              leader.y.compareTo(_knot[k].y)
            );
        }
      }
      _tailVisited.add(_knot.last);
    }
  }

  static final Map<String, Loc> dirs = {
    'R' : Loc.right,
    'L' : Loc.left,
    'U' : Loc.up,
    'D' : Loc.down,
  };
}
