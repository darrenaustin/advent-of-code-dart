// https://adventofcode.com/2016/day/13

import 'package:aoc/aoc.dart';
import 'package:aoc/util/binary.dart';
import 'package:aoc/util/pathfinding.dart';
import 'package:aoc/util/sparse_grid.dart';
import 'package:aoc/util/vec.dart';
import 'package:collection/collection.dart';

main() => Day13().solve();

class Day13 extends AdventDay {
  Day13() : super(2016, 13, name: 'A Maze of Twisty Little Cubicles');

  static const Vec2 _defaultGoal = Vec2(31, 39);

  @override
  dynamic part1(String input, [Vec2 goal = _defaultGoal]) {
    final maze = Maze(int.parse(input));
    return aStarLowestCost<Vec2>(
      start: Vec2(1, 1),
      goal: goal,
      estimatedDistance: (p) => p.manhattanDistanceTo(goal),
      costTo: (from, to) => from.manhattanDistanceTo(to),
      neighborsOf: (p) => Vec2.orthogonalDirs
          .map((d) => p + d)
          .where((p) => p.x >= 0 && p.y >= 0 && maze.isSpace(p)),
    )?.toInt();
  }

  @override
  dynamic part2(String input) {
    final maze = Maze(int.parse(input));
    final visited = <Vec2, int>{};

    void visit(Vec2 pos, int steps) {
      if (steps <= 50 && (!visited.containsKey(pos) || visited[pos]! > steps)) {
        visited[pos] = steps;
        final nextLocations = Vec2.orthogonalDirs
            .map((d) => pos + d)
            .where((p) => p.x >= 0 && p.y >= 0 && maze.isSpace(p));
        for (final next in nextLocations) {
          visit(next, steps + 1);
        }
      }
    }

    visit(Vec2(1, 1), 0);
    return visited.length;
  }
}

class Maze extends SparseGrid<int> {
  Maze(this.designerNumber) : super(defaultValue: 0);

  final int designerNumber;

  @override
  int cell(Vec2 p) {
    if (!isSet(p) && p.x >= 0 && p.y >= 0) {
      final x = p.xInt;
      final y = p.yInt;
      int value = x * x + 3 * x + 2 * x * y + y + y * y + designerNumber;
      setCell(p, value.bits.sum.isEven ? 0 : 1);
    }
    return super.cell(p);
  }

  bool isSpace(Vec2 pos) => cell(pos) == 0;
}
