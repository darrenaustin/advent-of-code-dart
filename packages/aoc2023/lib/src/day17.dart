// ignore_for_file: public_member_api_docs, sort_constructors_first
// https://adventofcode.com/2023/day/17

import 'package:aoc/aoc.dart';
import 'package:aoc/util/grid2.dart';
import 'package:aoc/util/pathfinding.dart';
import 'package:aoc/util/string.dart';
import 'package:aoc/util/vec.dart';

main() => Day17().solve();

class Day17 extends AdventDay {
  Day17() : super(2023, 17, name: 'Clumsy Crucible');

  @override
  dynamic part1(String input) {
    final data =
        input.lines.map((l) => l.chars.map(int.parse).toList()).toList();
    final grid = Grid<int>.from(data, 0);
    final start = Beam(Vec2.zero, Dir.right, 0);
    var goal = Vec2.int(grid.width - 1, grid.height - 1);

    double costTo(Beam a, Beam b) => grid.cell(b.pos).toDouble();

    Iterable<Beam> neighborsOf(Beam a) {
      final ns = <Beam>[];
      final dirs = [...a.dir.rightTurns(), if (a.steps < 3) a.dir];
      for (final d in dirs) {
        final newPos = a.pos + d.vec;
        if (grid.validCell(newPos)) {
          if (d == a.dir) {
            ns.add(Beam(newPos, d, a.steps + 1));
          } else {
            ns.add(Beam(newPos, d, 1));
          }
        }
      }
      return ns;
    }

    return dijkstraLowestCost(
      start: start,
      isGoal: (p) => p.pos == goal,
      costTo: costTo,
      neighborsOf: neighborsOf,
    )!
        .toInt();
  }

  @override
  dynamic part2(String input) {
    final data =
        input.lines.map((l) => l.chars.map(int.parse).toList()).toList();
    final grid = Grid<int>.from(data, 0);
    final start = Beam(Vec2.zero, Dir.right, 0);
    var goal = Vec2.int(grid.width - 1, grid.height - 1);

    double costTo(Beam a, Beam b) {
      var current = b.pos;
      double cost = 0;
      while (current != a.pos) {
        cost += grid.cell(current);
        current -= b.dir.vec;
      }
      return cost;
    }

    Iterable<Beam> neighborsOf(Beam a) {
      final ns = <Beam>[];
      final dirs = [...a.dir.rightTurns(), if (a.steps < 10) a.dir];
      for (final d in dirs) {
        if (d == a.dir) {
          final newPos = a.pos + d.vec;
          if (grid.validCell(newPos)) {
            ns.add(Beam(newPos, d, a.steps + 1));
          }
        } else {
          final newPos = a.pos + (d.vec * 4);
          if (grid.validCell(newPos)) {
            ns.add(Beam(newPos, d, 4));
          }
        }
      }
      return ns;
    }

    return dijkstraLowestCost(
      start: start,
      isGoal: (p) => p.pos == goal,
      // estimatedDistance: (p) => p.pos.manhattanDistanceTo(goal),
      costTo: costTo,
      neighborsOf: neighborsOf,
    )!
        .toInt();
  }
}

enum Dir {
  up(Vec2.up),
  down(Vec2.down),
  left(Vec2.left),
  right(Vec2.right);

  final Vec2 vec;

  const Dir(this.vec);

  Iterable<Dir> rightTurns() {
    switch (this) {
      case Dir.up:
      case Dir.down:
        return [Dir.left, Dir.right];

      case Dir.left:
      case Dir.right:
        return [Dir.up, Dir.down];
    }
  }
}

class Beam {
  final Vec2 pos;
  final Dir dir;
  final int steps;

  Beam(this.pos, this.dir, this.steps);

  @override
  bool operator ==(covariant Beam other) {
    if (identical(this, other)) return true;

    return other.pos == pos && other.dir == dir && other.steps == steps;
  }

  @override
  int get hashCode => pos.hashCode ^ dir.hashCode ^ steps.hashCode;

  @override
  String toString() => 'Beam(pos: $pos, dir: $dir, steps: $steps)';
}
