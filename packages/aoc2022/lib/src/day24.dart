// https://adventofcode.com/2022/day/24

import 'package:aoc/aoc.dart';
import 'package:aoc/util/grid2.dart';
import 'package:aoc/util/math.dart';
import 'package:aoc/util/range.dart';
import 'package:aoc/util/string.dart';
import 'package:aoc/util/vec.dart';

main() => Day24().solve();

class Day24 extends AdventDay {
  Day24() : super(2022, 24, name: 'Blizzard Basin');

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

  int minSteps(Valley valley, Vec start, Vec goal, int time) {
    Set<Vec> possibleMoves = {start};
    while (true) {
      time += 1;
      final nextMoves = <Vec>{};
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

    entrance = range(grid.width)
            .map((x) => Vec.int(x, 0))
            .where((p) => grid.cell(p) == '.')
            .first +
        Vec.upLeft;
    exit = range(grid.width)
            .map((x) => Vec.int(x, grid.height - 1))
            .where((p) => grid.cell(p) == '.')
            .first +
        Vec.upLeft;

    // Compute all spaces and find the blizzards.
    final Set<Vec> allSpaces = {entrance, exit};
    final List<Blizzard> blizzards = [];
    for (final y in range(1, grid.height - 1)) {
      for (final x in range(1, grid.width - 1)) {
        final gridPos = Vec.int(x, y);
        final pos = gridPos + Vec.upLeft;
        allSpaces.add(pos);
        final cell = grid.cell(gridPos);
        final dir = switch (cell) {
          '>' => Vec.right,
          '<' => Vec.left,
          '^' => Vec.up,
          'v' => Vec.down,
          _ => null,
        };
        if (dir != null) {
          blizzards.add(Blizzard(pos, dir));
        }
      }
    }

    // Compute all clear positions for each time in the wrapping period.
    for (final _ in range(_wrapPeriod)) {
      final Set<Vec> occupied = blizzards.map((b) => b.pos).toSet();
      for (final b in blizzards) {
        b.pos = Vec.int((b.pos.xInt + b.dir.xInt) % width,
            (b.pos.yInt + b.dir.yInt) % height);
      }
      _clearPositions.add(allSpaces.difference(occupied));
    }
  }

  late final Vec entrance;
  late final Vec exit;

  late final int _wrapPeriod;
  final List<Set<Vec>> _clearPositions = [];

  Iterable<Vec> clearNeighbors(Vec pos, int time) =>
      [...Vec.orthogonalDirs, Vec.zero]
          .map((d) => pos + d)
          .where((p) => _clearPositions[time % _wrapPeriod].contains(p));
}

class Blizzard {
  Blizzard(this.pos, this.dir);

  Vec pos;
  final Vec dir;
}
