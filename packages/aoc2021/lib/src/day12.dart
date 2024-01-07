// https://adventofcode.com/2021/day/12

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';

main() => Day12().solve();

class Day12 extends AdventDay {
  Day12() : super(2021, 12, name: 'Passage Pathing');

  @override
  dynamic part1(String input) {
    List<List<String>> paths(
        String start, String dest, Map<String, List<String>> mapData,
        [Set<String> visited = const <String>{}]) {
      if (start == dest) return [[]];
      visited = isSmallCave(start) ? visited.union({start}) : visited;
      final foundPaths = <List<String>>[];
      final nextStarts =
          mapData[start]!.where((c) => !isSmallCave(c) || !visited.contains(c));
      for (final next in nextStarts) {
        final newVisited = isSmallCave(next) ? visited.union({next}) : visited;
        final newPaths = paths(next, dest, mapData, newVisited);
        for (final newPath in newPaths) {
          foundPaths.add([next, ...newPath]);
        }
      }
      return foundPaths;
    }

    return paths('start', 'end', parseMapData(input)).length;
  }

  @override
  dynamic part2(String input) {
    List<List<String>> paths(
        String start, String dest, Map<String, List<String>> mapData,
        [String? doubleVisited, Set<String> visited = const <String>{}]) {
      if (start == dest) {
        return [
          [dest]
        ];
      }
      visited = isSmallCave(start) ? visited.union({start}) : visited;
      final foundPaths = <List<String>>[];
      late final Iterable<String> newStarts;
      if (doubleVisited != null) {
        newStarts = mapData[start]!
            .where((d) => !isSmallCave(d) || !visited.contains(d));
      } else {
        newStarts = mapData[start]!.where((d) => d != 'start');
      }
      for (final next in newStarts) {
        final newDoubleVisited = doubleVisited ??
            (isSmallCave(next) && visited.contains(next) ? next : null);
        final newVisited = isSmallCave(next) ? visited.union({next}) : visited;
        final newPaths =
            paths(next, dest, mapData, newDoubleVisited, newVisited);
        for (final newPath in newPaths) {
          foundPaths.add([start, ...newPath]);
        }
      }
      return foundPaths;
    }

    return paths('start', 'end', parseMapData(input)).length;
  }

  Map<String, List<String>> parseMapData(String input) {
    final paths = <String, List<String>>{};
    for (final line in input.lines) {
      final parts = line.split('-');
      final start = parts[0];
      final dest = parts[1];
      paths[start] = [...(paths[start] ?? []), dest];
      paths[dest] = [...(paths[dest] ?? []), start];
    }
    return paths;
  }

  static bool isSmallCave(String cave) => cave.toLowerCase() == cave;
}
