// ignore_for_file: public_member_api_docs, sort_constructors_first
// https://adventofcode.com/2023/day/17

import 'package:aoc/aoc.dart';
import 'package:aoc/util/collection.dart';
import 'package:aoc/util/grid2.dart';
import 'package:aoc/util/math.dart';
import 'package:aoc/util/string.dart';
import 'package:aoc/util/vec.dart';
import 'package:collection/collection.dart';

main() => Day17().solve();

class Day17 extends AdventDay {
  Day17() : super(2023, 17, name: 'Clumsy Crucible');

  @override
  dynamic part1(String input) {
    final data =
        input.lines.map((l) => l.chars.map(int.parse).toList()).toList();
    final grid = Grid<int>.from(data, 0);
    final start = HeatPathNode(0, Vec2.zero, Dir.right, 0);
    var goal = Vec2.int(grid.width - 1, grid.height - 1);

    final dist = <PathNode, int>{start.node: 0};
    final queue = PriorityQueue<HeatPathNode>()..add(start);

    while (queue.isNotEmpty) {
      var current = queue.removeFirst();
      if (current.node.pos == goal) {
        return current.heatLoss;
      }
      final neighbors = <HeatPathNode>[];
      final dirs = [
        if (current.node.steps < 3) current.node.dir,
        ...current.node.dir.rightTurns()
      ];
      for (final d in dirs) {
        final newPos = current.node.pos + d.vec;
        if (grid.validCell(newPos)) {
          final steps = (current.node.dir == d) ? current.node.steps + 1 : 1;
          neighbors.add(HeatPathNode(
              current.heatLoss + grid.cell(newPos), newPos, d, steps));
        }
      }
      for (final neighbor in neighbors) {
        if (neighbor.heatLoss < (dist.getOrElse(neighbor.node, maxInt))) {
          dist[neighbor.node] = neighbor.heatLoss;
          queue.add(neighbor);
        }
      }
    }
  }

  @override
  dynamic part2(String input) {
    final data =
        input.lines.map((l) => l.chars.map(int.parse).toList()).toList();
    final grid = Grid<int>.from(data, 0);
    final start = HeatPathNode(0, Vec2.zero, Dir.right, 0);
    var goal = Vec2.int(grid.width - 1, grid.height - 1);

    final dist = <PathNode, int>{start.node: 0};
    final queue = PriorityQueue<HeatPathNode>()..add(start);

    while (queue.isNotEmpty) {
      var current = queue.removeFirst();
      if (current.node.pos == goal) {
        return current.heatLoss;
      }
      final neighbors = <HeatPathNode>[];
      if (current.node.steps < 10) {
        final newPos = current.node.pos + current.node.dir.vec;
        if (grid.validCell(newPos)) {
          neighbors.add(HeatPathNode(current.heatLoss + grid.cell(newPos),
              newPos, current.node.dir, current.node.steps + 1));
        }
      }
      for (final d in current.node.dir.rightTurns()) {
        final newPos = current.node.pos + (d.vec * 4);
        if (grid.validCell(newPos)) {
          var cost = 0;
          var step = newPos;
          while (step != current.node.pos) {
            cost += grid.cell(step);
            step -= d.vec;
          }
          neighbors.add(HeatPathNode(current.heatLoss + cost, newPos, d, 4));
        }
      }
      for (final neighbor in neighbors) {
        if (neighbor.heatLoss < (dist.getOrElse(neighbor.node, maxInt))) {
          dist[neighbor.node] = neighbor.heatLoss;
          queue.add(neighbor);
        }
      }
    }
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

class PathNode {
  final Vec2 pos;
  final Dir dir;
  final int steps;

  PathNode(this.pos, this.dir, this.steps);

  @override
  bool operator ==(covariant PathNode other) {
    if (identical(this, other)) return true;

    return other.pos == pos && other.dir == dir && other.steps == steps;
  }

  @override
  int get hashCode => pos.hashCode ^ dir.hashCode ^ steps.hashCode;
}

class HeatPathNode implements Comparable {
  final int heatLoss;
  final PathNode node;

  HeatPathNode(this.heatLoss, Vec2 pos, Dir dir, int steps)
      : node = PathNode(pos, dir, steps);

  @override
  int compareTo(other) => heatLoss.compareTo((other as HeatPathNode).heatLoss);
}