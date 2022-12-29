// https://adventofcode.com/2015/day/9

import 'package:aoc/aoc.dart';
import 'package:aoc/util/collection.dart';
import 'package:aoc/util/comparison.dart';

class Day09 extends AdventDay {
  Day09() : super(2015, 9, solution1: 141, solution2: 736);

  @override
  dynamic part1() {
    return shortestDistance(inputRoutes());
  }

  @override
  dynamic part2() {
    return longestDistance(inputRoutes());
  }

  Map<String, Map<String, int>> inputRoutes() {
    final Map<String, Map<String, int>> routes = <String, Map<String, int>>{};
    inputDataLines().forEach((String line) {
      final RegExpMatch match = RegExp(r'(.+) to (.+) = (\d+)').firstMatch(line)!;
      final String from = match.group(1)!;
      final String to = match.group(2)!;
      final int distance = int.parse(match.group(3)!);
      routes[from] = routes.getOrElse(from, <String, int>{})..[to] = distance;
      routes[to] = routes.getOrElse(to, <String, int>{})..[from] = distance;
    });
    return routes;
  }

  int? minDistanceBy(Map<String, Map<String, int>> routes, Comparator<int>comparator) {
    int? shortestFrom(String location, Set<String> toVisit) {
      if (toVisit.isEmpty) {
        return 0;
      }
      final Map<String, int> destinations = routes[location]!;
      return toVisit.map((String d) {
        final int? destDistance = destinations[d];
        if (destDistance != null) {
          final int? shortestFromDest = shortestFrom(d, toVisit.difference(<String>{d}));
          return shortestFromDest != null ? destDistance + shortestFromDest : null;
        }
      }).whereType<int>().minBy(comparator);
    }

    final Set<String> locations = routes.keys.toSet();
    return locations
        .map((String l) => shortestFrom(l, locations.difference(<String>{l})))
        .whereType<int>()
        .minBy(comparator);
  }

  int? shortestDistance(Map<String, Map<String, int>> routes) {
    return minDistanceBy(routes, numMinComparator);
  }

  int? longestDistance(Map<String, Map<String, int>> routes) {
    return minDistanceBy(routes, numMaxComparator);
  }
}
