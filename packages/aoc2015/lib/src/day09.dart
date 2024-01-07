// https://adventofcode.com/2015/day/9

import 'package:aoc/aoc.dart';
import 'package:aoc/util/collection.dart';
import 'package:aoc/util/comparison.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day09().solve();

class Day09 extends AdventDay {
  Day09() : super(2015, 9, name: 'All in a Single Night');

  @override
  dynamic part1(String input) => minDistanceBy(parseRoutes(input));

  @override
  dynamic part2(String input) =>
      minDistanceBy(parseRoutes(input), numMaxComparator);

  int? minDistanceBy(Map<String, Map<String, int>> routes,
      [Comparator<int> comparator = numMinComparator]) {
    int? shortestFrom(String location, Set<String> toVisit) {
      if (toVisit.isEmpty) return 0;

      final destinations = routes[location]!;
      return toVisit
          .map((neighbor) {
            final int? destDistance = destinations[neighbor];
            if (destDistance != null) {
              final int? shortestFromDest =
                  shortestFrom(neighbor, toVisit.difference({neighbor}));
              return shortestFromDest != null
                  ? destDistance + shortestFromDest
                  : null;
            }
          })
          .whereNotNull()
          .minBy(comparator);
    }

    final locations = routes.keys.toSet();
    return locations
        .map((loc) => shortestFrom(loc, locations.difference(<String>{loc})))
        .whereNotNull()
        .minBy(comparator);
  }

  static Map<String, Map<String, int>> parseRoutes(String input) {
    final Map<String, Map<String, int>> routes = <String, Map<String, int>>{};
    for (final line in input.lines) {
      final RegExpMatch match =
          RegExp(r'(.+) to (.+) = (\d+)').firstMatch(line)!;
      final String from = match.group(1)!;
      final String to = match.group(2)!;
      final int distance = int.parse(match.group(3)!);
      (routes[from] ??= {})[to] = distance;
      (routes[to] ??= {})[from] = distance;
    }
    return routes;
  }
}
