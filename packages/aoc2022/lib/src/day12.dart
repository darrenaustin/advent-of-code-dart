// https://adventofcode.com/2022/day/12

import 'package:aoc/aoc.dart';
import 'package:aoc/util/grid2.dart';
import 'package:aoc/util/pathfinding.dart';
import 'package:aoc/util/string.dart';
import 'package:aoc/util/vec.dart';
import 'package:collection/collection.dart';

main() => Day12().solve();

class Day12 extends AdventDay {
  Day12() : super(2022, 12, name: 'Hill Climbing Algorithm');

  @override
  dynamic part1(String input) => Heightmap.from(input.lines).leastStepsToGoal();

  @override
  dynamic part2(String input) {
    final heightmap = Heightmap.from(input.lines);
    return heightmap
        .locationsWhere((p) => p == 'a')
        .map((s) => heightmap.leastStepsToGoal(s))
        .whereNotNull()
        .map((d) => d.toInt())
        .min;
  }
}

class Heightmap {
  Heightmap._(this._grid, this.start, this.goal);

  factory Heightmap.from(List<String> lines) {
    final data = lines.map((s) => s.split('').toList()).toList();
    final grid = Grid<String>.from(data, '');
    final start = grid.locationsWhere((p) => p == 'S').first;
    final goal = grid.locationsWhere((p) => p == 'E').first;
    grid.setCell(start, 'a');
    grid.setCell(goal, 'z');
    return Heightmap._(grid, start, goal);
  }

  int? leastStepsToGoal([Vec? start]) {
    return dijkstraLowestCost<Vec>(
      start: start ?? this.start,
      goal: goal,
      costTo: (_, __) => 1,
      neighborsOf: (l) => _grid.neighborLocations(l, Vec.orthogonalDirs).where(
          (e) =>
              _grid.cell(e).codeUnitAt(0) - _grid.cell(l).codeUnitAt(0) <= 1),
    )?.toInt();
  }

  Iterable<Vec> locationsWhere(bool Function(String) test) =>
      _grid.locationsWhere(test);

  final Grid<String> _grid;
  final Vec start;
  final Vec goal;
}
