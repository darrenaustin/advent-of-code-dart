// https://adventofcode.com/2019/day/6

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day06().solve();

class Day06 extends AdventDay {
  Day06() : super(2019, 6, name: 'Universal Orbit Map');

  @override
  dynamic part1(String input) {
    final orbits = inputOrbits(input);
    return orbits.keys.map((b) => numOrbits(b, orbits)).sum;
  }

  @override
  dynamic part2(String input) {
    final orbits = inputOrbits(input);
    final connects = connections(orbits);
    return minTransfers(orbits['YOU']!, orbits['SAN']!, connects);
  }

  Map<String, String> inputOrbits(String input) {
    return Map.fromEntries(input.lines.map((l) {
      final objects = l.split(')');
      return MapEntry(objects.last, objects.first);
    }));
  }

  int numOrbits(String body, Map<String, String> orbits) {
    if (orbits.containsKey(body)) {
      return 1 + numOrbits(orbits[body]!, orbits);
    }
    return 0;
  }

  Map<String, Set<String>> connections(Map<String, String> orbits) {
    final connections = <String, Set<String>>{};
    orbits.forEach((key, value) {
      connections[key] = (connections[key] ?? <String>{})..add(value);
      connections[value] = (connections[value] ?? <String>{})..add(key);
    });
    return connections;
  }

  int? minTransfers(
      String from, String to, Map<String, Set<String>> connections) {
    final cache = <String, int?>{};

    int? cachedTransfers(String from, String to,
        Map<String, Set<String>> connections, Set<String> visited) {
      int? transfers(String from, String to,
          Map<String, Set<String>> connections, Set<String> visited) {
        if (from == to) {
          return 0;
        }
        if (connections[from]!.contains(to)) {
          return 1;
        }
        final transfers = connections[from]!
            .where((b) => !visited.contains(b))
            .map((b) =>
                cachedTransfers(b, to, connections, visited.union({from})))
            .whereNotNull();
        return transfers.isNotEmpty ? 1 + transfers.min : null;
      }

      final key = '$from$to';
      if (cache.containsKey(key)) {
        return cache[key];
      }
      final value = transfers(from, to, connections, visited);
      if (value != null) {
        cache[key] = value;
        cache['$to$from'] = value;
      }
      return value;
    }

    return cachedTransfers(from, to, connections, {});
  }
}
