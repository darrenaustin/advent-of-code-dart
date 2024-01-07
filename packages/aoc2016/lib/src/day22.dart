// https://adventofcode.com/2016/day/22

import 'dart:math';

import 'package:aoc/aoc.dart';
import 'package:aoc/util/pathfinding.dart';
import 'package:aoc/util/string.dart';
import 'package:aoc/util/vec.dart';

main() => Day22().solve();

class Day22 extends AdventDay {
  Day22() : super(2016, 22, name: 'Grid Computing');

  @override
  dynamic part1(String input) {
    final nodes = parseNodes(input);
    int numViable = 0;
    for (int i = 0; i < nodes.length - 1; i++) {
      for (int j = i + 1; j < nodes.length; j++) {
        if (nodes[i].viableWith(nodes[j])) {
          numViable++;
        }
      }
    }
    return numViable;
  }

  @override
  dynamic part2(String input) {
    final nodes = parseNodes(input);

    // For performance, the following is assumed:
    // - There is only one empty node.
    // - Each other node is either too big to move, or can only
    //   be moved into the empty node.
    // These are true for the example and my input.

    int width = 0;
    int height = 0;
    late Vec2 empty;
    final invalidLocations = <Vec2>{...nodes.map((n) => n.position)};

    for (int i = 0; i < nodes.length; i++) {
      final node = nodes[i];
      if (node.used == 0) {
        empty = node.position;
      }
      width = max(width, node.position.xInt);
      height = max(height, node.position.yInt);
      if (i < nodes.length - 1) {
        for (int j = i + 1; j < nodes.length; j++) {
          if (node.viableWith(nodes[j])) {
            invalidLocations.remove(node.position);
            invalidLocations.remove(nodes[j].position);
          }
        }
      }
    }

    bool validLocation(Vec2 loc) =>
        0 <= loc.x &&
        loc.x <= width &&
        0 <= loc.y &&
        loc.y <= height &&
        !invalidLocations.contains(loc);

    final start = GoalData(Vec2.int(width, 0), empty);
    return aStarLowestCost<GoalData>(
      start: start,
      isGoal: (g) => g.goal == Vec2.zero,
      estimatedDistance: (g) =>
          g.goal.manhattanDistanceTo(Vec2.zero) +
          g.goal.manhattanDistanceTo(g.empty),
      costTo: (g1, g2) => 1,
      neighborsOf: (g) => Vec2.orthogonalDirs
          .map((d) => g.empty + d)
          .where(validLocation)
          .map((p) => p == g.goal ? GoalData(g.empty, p) : GoalData(g.goal, p)),
    );
  }

  List<Node> parseNodes(String input) =>
      input.lines.skip(2).map(Node.parse).toList();
}

class Node {
  Node(this.position, this.size, this.used);

  static Node parse(String input) {
    final match = RegExp(r'-x(\d+)-y(\d+)\s*(\d+)T\s*(\d+)T').firstMatch(input);
    if (match == null) {
      throw Exception('Unable to parse node info: $input');
    }
    return Node(
      Vec2(double.parse(match.group(1)!), double.parse(match.group(2)!)),
      int.parse(match.group(3)!),
      int.parse(match.group(4)!),
    );
  }

  final Vec2 position;
  final int size;
  final int used;
  int get available => size - used;

  bool viableWith(Node other) {
    return (used > 0 && other.available >= used) ||
        (other.used > 0 && available >= other.used);
  }

  @override
  String toString() =>
      'Node $position size = $size, used = $used, available = $available';
}

class GoalData {
  GoalData(this.goal, this.empty);

  final Vec2 goal;
  final Vec2 empty;

  @override
  int get hashCode => goal.hashCode ^ empty.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is GoalData && other.goal == goal && other.empty == empty;
  }
}
