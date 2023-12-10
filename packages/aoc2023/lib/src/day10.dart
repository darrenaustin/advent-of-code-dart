// https://adventofcode.com/2023/day/10

import 'package:aoc/aoc.dart';
import 'package:aoc/util/grid2.dart';
import 'package:aoc/util/string.dart';
import 'package:aoc/util/vec.dart';

main() => Day10().solve();

class Day10 extends AdventDay {
  Day10() : super(2023, 10, name: 'Pipe Maze');

  @override
  dynamic part1(String input) => findPath(parseGrid(input)).length / 2;

  @override
  dynamic part2(String input) {
    final grid = parseGrid(input);
    final path = findPath(grid).toList();
    removeNonPathPipes(grid, path);
    updateStartWithPipe(grid, path);
    return numEnclosed(grid, path);
  }

  Grid<String> parseGrid(String input) {
    final data = input.lines.map((l) => l.chars).toList();
    return Grid<String>.from(data, '.');
  }

  static final pipeDirs = {
    '|': {Vec2.up: Vec2.up, Vec2.down: Vec2.down},
    '-': {Vec2.left: Vec2.left, Vec2.right: Vec2.right},
    'L': {Vec2.down: Vec2.right, Vec2.left: Vec2.up},
    'J': {Vec2.right: Vec2.up, Vec2.down: Vec2.left},
    '7': {Vec2.right: Vec2.down, Vec2.up: Vec2.left},
    'F': {Vec2.up: Vec2.right, Vec2.left: Vec2.down},
  };

  Vec2 findPathStart(Grid<String> grid) =>
      grid.locationsWhere((p) => p == 'S').first;

  Iterable<Vec2> findPath(Grid<String> grid) {
    final start = findPathStart(grid);
    final possibleDirs =
        Vec2.orthogonalDirs.where((p) => grid.validCell(p + start));
    for (final d in possibleDirs) {
      final path = pathFrom(grid, start, d);
      if (path != null) {
        return path;
      }
    }
    throw Exception('Unable to find path.');
  }

  Iterable<Vec2>? pathFrom(Grid<String> grid, Vec2 start, Vec2 dir) {
    final path = [start];
    var current = start + dir;
    while (current != start) {
      if (!grid.validCell(current)) {
        return null;
      }
      final currentCell = grid.cell(current);
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

  void removeNonPathPipes(Grid<String> grid, Iterable<Vec2> path) {
    final pathLocs = path.toSet();
    for (final loc in grid.locations().where((l) => !pathLocs.contains(l))) {
      grid.setCell(loc, '.');
    }
  }

  static final startPipes = {
    Vec2.up: {Vec2.down: '|', Vec2.left: 'J', Vec2.right: 'L'},
    Vec2.down: {Vec2.up: '|', Vec2.left: '7', Vec2.right: 'F'},
    Vec2.left: {Vec2.right: '-', Vec2.up: 'J', Vec2.down: '7'},
    Vec2.right: {Vec2.left: '-', Vec2.up: 'L', Vec2.down: 'F'},
  };

  void updateStartWithPipe(Grid<String> grid, List<Vec2> path) {
    final dir1 = path[1] - path[0];
    final dir2 = path.last - path[0];
    grid.setCell(path[0], startPipes[dir1]![dir2]!);
  }

  int numEnclosed(Grid<String> grid, List<Vec2> path) {
    var inside = 0;

    // Walk the grid, row by row and keep track of up-facing crossings
    // of the path. If we hit an empty space and the crossings so far
    // are odd, then it is inside. This is the Crossing Number method
    // for testing inclusion of a point in a polygon.
    for (int y = 0; y < grid.height; y++) {
      var crossings = 0;
      for (int x = 0; x < grid.width; x++) {
        final loc = Vec2.int(x, y);
        switch (grid.cell(loc)) {
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
