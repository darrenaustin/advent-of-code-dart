// https://adventofcode.com/2022/day/24

import 'package:aoc/aoc.dart';
import 'package:aoc/util/collection.dart';
import 'package:aoc/util/grid2.dart';
import 'package:aoc/util/math.dart';
import 'package:aoc/util/string.dart';
import 'package:aoc/util/vec2.dart';

main() => Day24().solve();

class Day24 extends AdventDay {
  Day24() : super(
    2022, 24, name: 'Blizzard Basin',
    solution1: 225, solution2: 711,
  );

  @override
  dynamic part1(String input) {
    final valley = Valley(input.lines);
    return minSteps(valley, valley.entrance, valley.exit, 0);
  }

  @override
  dynamic part2(String input) {
    final valley = Valley(input.lines);
    final trip1 = minSteps(valley, valley.entrance, valley.exit, 0);
    final trip2 = minSteps(valley, valley.exit, valley.entrance, trip1);
    return minSteps(valley, valley.entrance, valley.exit, trip2);
  }

  int minSteps(Valley valley, Vec2 start, Vec2 goal, int time) {
    Set<Vec2> possibleMoves = {start};
    while (true) {
      time += 1;
      final nextMoves = <Vec2>{};
      for (final m in possibleMoves) {
        final potentialMoves = valley.clearNeighbors(m, time);
        if (potentialMoves.contains(goal)) {
          return time;
        }
        nextMoves.addAll(potentialMoves);
      }
      possibleMoves = nextMoves;
    }
  }
}

class Valley {
  Valley(List<String> fieldData) {
    final grid = Grid.from(fieldData.map((l) => l.split('')).toList(), '.');

    // Given the way the blizzards wrap around, the entire grid
    // will repeat again in cycles based on the width and height
    // of the open inner space.
    final width = grid.width - 2;
    final height = grid.height - 2;
    _wrapPeriod = lcm(width, height);

    entrance = range(grid.width).map((x) => Vec2.int(x, 0)).where((p) => grid.cell(p) == '.').first + Vec2.upLeft;
    exit = range(grid.width).map((x) => Vec2.int(x, grid.height - 1)).where((p) => grid.cell(p) == '.').first + Vec2.upLeft;

    // Compute all spaces and find the blizzards.
    final Set<Vec2> allSpaces = {entrance, exit};
    final List<Blizzard> blizzards = [];
    for (final y in range(1, grid.height - 1)) {
      for (final x in range(1, grid.width - 1)) {
        final gridPos = Vec2.int(x, y);
        final pos = gridPos + Vec2.upLeft;
        allSpaces.add(pos);
        final cell = grid.cell(gridPos);
        switch (cell) {
          case '>': blizzards.add(Blizzard(pos, Vec2.right)); break;
          case '<': blizzards.add(Blizzard(pos, Vec2.left)); break;
          case '^': blizzards.add(Blizzard(pos, Vec2.up)); break;
          case 'v': blizzards.add(Blizzard(pos, Vec2.down)); break;
        }
      }
    }

    // Compute all clear positions for each time in the wrapping period.
    for (final _ in range(_wrapPeriod)) {
      final Set<Vec2> occupied = blizzards.map((b) => b.pos).toSet();
      for (final b in blizzards) {
        b.pos = Vec2.int(
          (b.pos.xInt + b.dir.xInt) % width,
          (b.pos.yInt + b.dir.yInt) % height
        );
      }
      _clearPositions.add(allSpaces.difference(occupied));
    }
  }

  late final Vec2 entrance;
  late final Vec2 exit;

  late final int _wrapPeriod;
  final List<Set<Vec2>> _clearPositions = [];

  Iterable<Vec2> clearNeighbors(Vec2 pos, int time) =>
    [...Vec2.orthogonalDirs, Vec2.zero]
      .map((d) => pos + d)
      .where((p) => _clearPositions[time % _wrapPeriod].contains(p));
}

class Blizzard {
  Blizzard(this.pos, this.dir);

  Vec2 pos;
  final Vec2 dir;
}
