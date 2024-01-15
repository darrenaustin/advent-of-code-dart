// https://adventofcode.com/2016/day/24

import 'package:aoc/aoc.dart';
import 'package:aoc/util/combinatorics.dart';
import 'package:aoc/util/grid2.dart';
import 'package:aoc/util/range.dart';
import 'package:aoc/util/string.dart';
import 'package:aoc/util/vec.dart';
import 'package:collection/collection.dart';

main() => Day24().solve();

class Day24 extends AdventDay {
  Day24() : super(2016, 24, name: 'Air Duct Spelunking');

  @override
  dynamic part1(String input) => shortestPath(input);

  @override
  dynamic part2(String input) => shortestPath(input, true);

  int shortestPath(String input, [bool returnToStart = false]) {
    final grid = Grid.fromString(input);

    // BFS search between to grid postions
    int? distanceBetween(Vec2 from, Vec2 to) {
      final queue = <(Vec2, int)>[(from, 0)];
      final visited = <Vec2>{from};

      while (queue.isNotEmpty) {
        final (node, dist) = queue.removeAt(0);
        if (node == to) {
          return dist;
        }
        for (final dir in Vec2.orthogonalDirs) {
          final next = node + dir;
          if (grid.validCell(next) &&
              grid.cell(next) != '#' &&
              !visited.contains(next)) {
            visited.add(next);
            queue.add((next, dist + 1));
          }
        }
      }
      return null;
    }

    // Find the starting and goal postitions in the grid.
    final start = grid.locationsWhere((c) => c == '0').first;
    final goals = grid.locationsWhere((c) => c != '0' && c.isDigit).toList();

    // Calculte the distances between the start and each goal, as well
    // as the distance between each pair of goal locations.
    final numGoals = goals.length;
    final distFrom0 = goals.map((g) => distanceBetween(start, g)!).toList();
    final distances = List.generate(numGoals, (_) => List.filled(numGoals, 0));
    for (int i = 0; i < numGoals - 1; i++) {
      for (int j = i + 1; j < numGoals; j++) {
        distances[i][j] =
            distances[j][i] = distanceBetween(goals[i], goals[j])!;
      }
    }

    // Return the total distance for a given path through the goals.
    int pathDistance(Iterable<int> path) {
      final initial = (distFrom0[path.first], path.first);
      final totalDistance = path
          .skip(1)
          .fold(initial,
              (curr, next) => (curr.$1 + distances[curr.$2][next], next))
          .$1;
      return totalDistance + (returnToStart ? distFrom0[path.last] : 0);
    }

    // Just walk through all possible paths across all goals and find
    // the shortest.
    return permutations(range(numGoals)).map(pathDistance).min;
  }
}