// https://adventofcode.com/2023/day/10

import 'package:aoc/aoc.dart';
import 'package:aoc/util/grid2.dart';
import 'package:aoc/util/string.dart';
import 'package:aoc/util/vec.dart';

main() => Day10().solve();

class Day10 extends AdventDay {
  Day10() : super(2023, 10, name: '');

  @override
  dynamic part1(String input) {
    final grid = parseGrid(input);
    final Vec2 start = grid.locationsWhere((p) => p == 'S').first;
    final path = findMainPath(grid, start);
    return path!.length ~/ 2;
  }

  @override
  dynamic part2(String input) {
    final grid = parseGrid(input);
    final Vec2 start = grid.locationsWhere((p) => p == 'S').first;
    final path = findMainPath(grid, start)!.toList();
    grid.setCell(start, determineStartPipe(grid, path));
    return numEnclosed(grid, path);
  }

  Grid<String> parseGrid(String input) {
    final data = input.lines.map((l) => l.chars).toList();
    return Grid<String>.from(data, '.');
  }

  final Map<String, List<Vec2>> connectionDirs = {
    '|': [Vec2.up, Vec2.down],
    '-': [Vec2.left, Vec2.right],
    'L': [Vec2.up, Vec2.right],
    'J': [Vec2.up, Vec2.left],
    '7': [Vec2.down, Vec2.left],
    'F': [Vec2.down, Vec2.right],
    '.': [],
    'S': Vec2.orthogonalDirs,
  };

  final continueDirs = {
    '|': {Vec2.up: Vec2.up, Vec2.down: Vec2.down},
    '-': {Vec2.left: Vec2.left, Vec2.right: Vec2.right},
    'L': {Vec2.down: Vec2.right, Vec2.left: Vec2.up},
    'J': {Vec2.right: Vec2.up, Vec2.down: Vec2.left},
    '7': {Vec2.right: Vec2.down, Vec2.up: Vec2.left},
    'F': {Vec2.up: Vec2.right, Vec2.left: Vec2.down},
  };

  Iterable<Vec2>? findMainPath(Grid<String> grid, Vec2 start) {
    final possibleDirs =
        Vec2.orthogonalDirs.where((p) => grid.validCell(p + start));
    for (final d in possibleDirs) {
      final path = mainPath(grid, start, d);
      if (path != null) {
        return path;
      }
    }
    return null;
  }

  Iterable<Vec2>? mainPath(Grid<String> grid, Vec2 start, Vec2 dir) {
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

      final nextDir = continueDirs[currentCell]![dir];
      if (nextDir == null) {
        return null;
      }

      path.add(current);
      dir = nextDir;
      current = current + dir;
    }
    return path;
  }

  int numEnclosed(Grid<String> grid, List<Vec2> path) {
    final pathLocs = path.toSet();
    final outside = <Vec2>{
      // Top border
      for (int x = 0; x < grid.width; x++) Vec2.int(x, 0),
      // Bottom border
      for (int x = 0; x < grid.width; x++) Vec2.int(x, grid.height - 1),
      // Left border
      for (int y = 1; y < grid.height - 1; y++) Vec2.int(0, y),
      // Right border
      for (int y = 1; y < grid.height - 1; y++) Vec2.int(grid.width - 1, y),
    }.difference(pathLocs);
    final inside = <Vec2>{};

    final candidates =
        grid.locations().toSet().difference(outside).difference(pathLocs);

    assert(candidates.every((c) => !pathLocs.contains(c)));

    while (candidates.isNotEmpty) {
      final connected = <Vec2>{candidates.first};
      final expandFrom = <Vec2>{candidates.first};
      while (expandFrom.isNotEmpty) {
        final candidate = expandFrom.first;
        expandFrom.remove(candidate);

        final neighbors =
            grid.neighborLocations(candidate, Vec2.orthogonalDirs);
        if (neighbors.any((n) => outside.contains(n))) {
          outside.addAll(connected);
          candidates.removeAll(connected);
          connected.clear();
          expandFrom.clear();
        } else {
          for (final loc in neighbors) {
            if (pathLocs.contains(loc)) {
              final exit = pipeExit(grid, pathLocs, loc, loc - candidate);
              if (exit != null && grid.validCell(exit)) {
                assert(!pathLocs.contains(exit));
                if (outside.contains(exit)) {
                  outside.addAll(connected);
                  candidates.removeAll(connected);
                  connected.clear();
                  expandFrom.clear();
                } else if (!connected.contains(exit) &&
                    !pathLocs.contains(exit)) {
                  connected.add(exit);
                  expandFrom.add(exit);
                }
              }
            } else if (!connected.contains(loc)) {
              connected.add(loc);
              expandFrom.add(loc);
            }
          }
        }
      }
      if (connected.isNotEmpty) {
        inside.addAll(connected);
        candidates.removeAll(connected);
      }
    }

    if (inside.any((l) => pathLocs.contains(l))) {
      print('Inside includes path elements:');
      print('  inside: $inside');
      print('  path:  $path');
    }

    // final g = grid.copy();
    // for (final l in outside) {
    //   g.setCell(l, 'O');
    // }
    // for (final l in inside) {
    //   g.setCell(l, 'I');
    // }
    // print(g);

    return inside.length;
  }

  static final verticalDirs = [Vec2.up, Vec2.down];
  static final horizontalDirs = [Vec2.left, Vec2.right];

  static final pipeSides = {
    '|': {Vec2.up: false, Vec2.down: false, Vec2.left: true, Vec2.right: true},
    '-': {Vec2.up: true, Vec2.down: true, Vec2.left: false, Vec2.right: false},
    'L': {Vec2.up: false, Vec2.down: true, Vec2.left: true, Vec2.right: false},
    'J': {Vec2.up: false, Vec2.down: true, Vec2.left: false, Vec2.right: true},
    '7': {Vec2.up: true, Vec2.down: false, Vec2.left: false, Vec2.right: true},
    'F': {Vec2.up: true, Vec2.down: false, Vec2.left: true, Vec2.right: false},
  };

  Vec2? pipeExit(Grid<String> grid, Set<Vec2> path, Vec2 starting, Vec2 dir) {
    final sideDirs = verticalDirs.contains(dir) ? horizontalDirs : verticalDirs;

    for (final sideDir in sideDirs) {
      var followPathLoc = starting;
      bool blocked = false;
      while (path.contains(followPathLoc) && !blocked) {
        if (!pipeSides[grid.cell(followPathLoc)]![sideDir]!) {
          blocked = true;
        } else {
          followPathLoc = followPathLoc + dir;
        }
      }
      if (blocked) {
        continue;
      }
      return followPathLoc;
    }
    return null;
  }

  static final startPipes = {
    {Vec2.up, Vec2.down}: '|',
    {Vec2.left, Vec2.right}: '-',
    {Vec2.up, Vec2.right}: 'L',
    {Vec2.up, Vec2.left}: 'J',
    {Vec2.down, Vec2.left}: '7',
    {Vec2.down, Vec2.right}: 'F',
  };

  String determineStartPipe(Grid<String> grid, List<Vec2> path) {
    final startDirs = {path[1] - path[0], path.last - path[0]};

    if (setEquals(startDirs, {Vec2.up, Vec2.down})) {
      return '|';
    }
    if (setEquals(startDirs, {Vec2.left, Vec2.right})) {
      return '-';
    }
    if (setEquals(startDirs, {Vec2.up, Vec2.right})) {
      return 'L';
    }
    if (setEquals(startDirs, {Vec2.up, Vec2.left})) {
      return 'J';
    }
    if (setEquals(startDirs, {Vec2.down, Vec2.left})) {
      return '7';
    }
    if (setEquals(startDirs, {Vec2.down, Vec2.right})) {
      return 'F';
    }
    throw Exception('Unknown pipe for $startDirs');
  }

  bool setEquals<T>(Set<T>? a, Set<T>? b) {
    if (a == null) {
      return b == null;
    }
    if (b == null || a.length != b.length) {
      return false;
    }
    if (identical(a, b)) {
      return true;
    }
    for (final T value in a) {
      if (!b.contains(value)) {
        return false;
      }
    }
    return true;
  }
}
