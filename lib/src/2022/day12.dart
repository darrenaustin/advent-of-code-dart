// https://adventofcode.com/2022/day/12

import 'package:collection/collection.dart';

import '../../day.dart';
import '../util/grid2.dart';
import '../util/pathfinding.dart';
import '../util/vec2.dart';

class Day12 extends AdventDay {
  Day12() : super(2022, 12, solution1: 383, solution2: 377);

  @override
  dynamic part1() => Heightmap.from(inputDataLines()).leastStepsToGoal();

  @override
  dynamic part2() {
    final heightmap = Heightmap.from(inputDataLines());
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
    final data = lines
      .map((s) => s.split('').toList())
      .toList();
    final grid = Grid<String>.from(data, '');
    final start = grid.locationsWhere((p) => p == 'S').first;
    final goal = grid.locationsWhere((p) => p == 'E').first;
    grid.setCell(start, 'a');
    grid.setCell(goal, 'z');
    return Heightmap._(grid, start, goal);
  }

  int? leastStepsToGoal([Vec2? start]) {
    return dijkstraLowestCost<Vec2>(
      start: start ?? this.start,
      goal: goal,
      costTo: (_, __) => 1,
      neighborsOf: (l) => _grid
        .neighborLocations(l, Vec2.orthogonalDirs)
        .where((e) => _grid.cell(e).codeUnitAt(0) - _grid.cell(l).codeUnitAt(0) <= 1),
    )?.toInt();
  }

  Iterable<Vec2> locationsWhere(bool Function(String) test) => _grid.locationsWhere(test);

  final Grid<String> _grid;
  final Vec2 start;
  final Vec2 goal;

}
