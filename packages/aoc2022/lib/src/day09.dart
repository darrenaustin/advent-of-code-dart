// https://adventofcode.com/2022/day/9

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:aoc/util/vec.dart';

main() => Day09().solve();

class Day09 extends AdventDay {
  Day09() : super(
    2022, 9, name: 'Rope Bridge',
    solution1: 6236, solution2: 2449,
  );

  @override
  dynamic part1(String input) {
    final rope = Rope(2);
    rope.followInstructions(input.lines);
    return rope.numTailVisited();
  }

  @override
  dynamic part2(String input) {
    final rope = Rope(10);
    rope.followInstructions(input.lines);
    return rope.numTailVisited();
  }
}

class Rope {
  Rope(int knots) :
    _knot = List.generate(knots, (_) => Vec2.zero),
    _tailVisited = <Vec2>{Vec2.zero};

  final List<Vec2> _knot;
  final Set<Vec2> _tailVisited;

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

  void moveHead(Vec2 dir, int amount) {
    for (int i = 0; i < amount; i++) {
      _knot[0] += dir;
      for (int k = 1; k < _knot.length; k++) {
        final Vec2 leader = _knot[k - 1];
        if (!Vec2.cardinalDirs.any((l) => (leader + l) == _knot[k])) {
            // Not in any of the surrounding spaces of the leader, so
            // move the knot in the direction of the leader.
            _knot[k] += Vec2.int(
              leader.x.compareTo(_knot[k].x),
              leader.y.compareTo(_knot[k].y)
            );
        }
      }
      _tailVisited.add(_knot.last);
    }
  }

  static final dirs = {
    'R' : Vec2.right,
    'L' : Vec2.left,
    'U' : Vec2.up,
    'D' : Vec2.down,
  };
}
