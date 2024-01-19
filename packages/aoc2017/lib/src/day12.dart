// https://adventofcode.com/2017/day/12

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day12().solve();

class Day12 extends AdventDay {
  Day12() : super(2017, 12, name: 'Digital Plumber');

  @override
  dynamic part1(String input) => connectedTo(0, parsePipes(input)).length;

  @override
  dynamic part2(String input) {
    final pipes = parsePipes(input);
    final sets = <Set<int>>[];
    for (final id in pipes.keys) {
      if (sets.none((s) => s.contains(id))) {
        sets.add(connectedTo(id, pipes));
      }
    }
    return sets.length;
  }

  Set<int> connectedTo(int start, Map<int, List<int>> pipes) {
    final connected = <int>{};
    final queue = [start];
    while (queue.isNotEmpty) {
      int id = queue.removeAt(0);
      if (connected.add(id)) {
        queue.addAll(pipes[id]!);
      }
    }
    return connected;
  }

  Map<int, List<int>> parsePipes(String input) {
    final pipes = <int, List<int>>{};
    for (final line in input.lines) {
      final [start, destinations] = line.split(' <-> ');
      final startId = int.parse(start);
      final connectionIds = destinations.split(', ').map(int.parse).toList();
      pipes[startId] = connectionIds;
    }
    return pipes;
  }
}
