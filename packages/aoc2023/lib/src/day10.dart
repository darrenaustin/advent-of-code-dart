// https://adventofcode.com/2023/day/10

import 'package:aoc/aoc.dart';
import 'package:aoc/util/grid.dart';
import 'package:aoc/util/vec.dart';

main() => Day10().solve();

class Day10 extends AdventDay {
  Day10() : super(2023, 10, name: 'Pipe Maze');

  @override
  dynamic part1(String input) => findPath(Grid.parse(input)).length / 2;

  @override
  dynamic part2(String input) {
    final grid = Grid.parse(input);
    final path = findPath(grid).toList();
    removeNonPathPipes(grid, path);
    updateStartWithPipe(grid, path);
    return numEnclosed(grid, path);
  }

  static final pipeDirs = {
    '|': {Vec.up: Vec.up, Vec.down: Vec.down},
    '-': {Vec.left: Vec.left, Vec.right: Vec.right},
    'L': {Vec.down: Vec.right, Vec.left: Vec.up},
    'J': {Vec.right: Vec.up, Vec.down: Vec.left},
    '7': {Vec.right: Vec.down, Vec.up: Vec.left},
    'F': {Vec.up: Vec.right, Vec.left: Vec.down},
  };

  Vec findPathStart(Grid<String> grid) =>
      grid.locationsWhereValue((p) => p == 'S').first;

  Iterable<Vec> findPath(Grid<String> grid) {
    final start = findPathStart(grid);
    final possibleDirs =
        Vec.orthogonalDirs.where((p) => grid.validLocation(p + start));
    for (final d in possibleDirs) {
      final path = pathFrom(grid, start, d);
      if (path != null) {
        return path;
      }
    }
    throw Exception('Unable to find path.');
  }

  Iterable<Vec>? pathFrom(Grid<String> grid, Vec start, Vec dir) {
    final path = [start];
    var current = start + dir;
    while (current != start) {
      if (!grid.validLocation(current)) {
        return null;
      }
      final currentCell = grid.value(current);
      if (currentCell == '.') {
        return null;
      }

      final nextDir = pipeDirs[currentCell]![dir];
      if (nextDir == null) {
        return null;
      }

      path.add(current);
      dir = nextDir;
      current = current + dir;
    }
    return path;
  }

  void removeNonPathPipes(Grid<String> grid, Iterable<Vec> path) {
    final pathLocs = path.toSet();
    for (final loc in grid.locations().where((l) => !pathLocs.contains(l))) {
      grid.setValue(loc, '.');
    }
  }

  static final startPipes = {
    Vec.up: {Vec.down: '|', Vec.left: 'J', Vec.right: 'L'},
    Vec.down: {Vec.up: '|', Vec.left: '7', Vec.right: 'F'},
    Vec.left: {Vec.right: '-', Vec.up: 'J', Vec.down: '7'},
    Vec.right: {Vec.left: '-', Vec.up: 'L', Vec.down: 'F'},
  };

  void updateStartWithPipe(Grid<String> grid, List<Vec> path) {
    final dir1 = path[1] - path[0];
    final dir2 = path.last - path[0];
    grid.setValue(path[0], startPipes[dir1]![dir2]!);
  }

  int numEnclosed(Grid<String> grid, List<Vec> path) {
    var inside = 0;

    // Walk the grid, row by row and keep track of up-facing crossings
    // of the path. If we hit an empty space and the crossings so far
    // are odd, then it is inside. This is the Crossing Number method
    // for testing inclusion of a point in a polygon.
    for (int y = 0; y < grid.height; y++) {
      var crossings = 0;
      for (int x = 0; x < grid.width; x++) {
        final loc = Vec(x, y);
        switch (grid.value(loc)) {
          case '.':
            if (crossings % 2 == 1) {
              inside++;
            }
          case '|':
          case 'J':
          case 'L':
            crossings++;
        }
      }
    }
    return inside;
  }
}
