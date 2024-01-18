// https://adventofcode.com/2019/day/3

import 'package:aoc/aoc.dart';
import 'package:aoc/util/line.dart';
import 'package:aoc/util/string.dart';
import 'package:aoc/util/vec.dart';
import 'package:collection/collection.dart';

main() => Day03().solve();

class Day03 extends AdventDay {
  Day03() : super(2019, 3, name: 'Crossed Wires');

  @override
  dynamic part1(String input) {
    final origin = Vec.zero;
    final wireSegments = wirePaths(input).map((p) => segmentsFrom(origin, p));
    final wire1 = wireSegments.first;
    final wire2 = wireSegments.last;

    final intersections = <Vec>{};
    for (final s1 in wire1) {
      intersections
          .addAll(wire2.map((s2) => s1.intersection(s2)).whereNotNull());
    }
    intersections.remove(origin);
    return intersections.map((v) => v.manhattanDistanceTo(origin)).min.toInt();
  }

  @override
  dynamic part2(String input) {
    final origin = Vec.zero;
    final wireSegments = wirePaths(input).map((p) => segmentsFrom(origin, p));
    final wire1 = wireSegments.first;
    final wire2 = wireSegments.last;

    final intersections = <Vec>{};
    for (final s1 in wire1) {
      intersections
          .addAll(wire2.map((s2) => s1.intersection(s2)).whereNotNull());
    }
    intersections.remove(origin);
    return intersections
        .map((v) => distanceTo(v, wire1) + distanceTo(v, wire2))
        .min
        .toInt();
  }

  static final _dirVec2s = {
    'U': Vec.up,
    'D': Vec.down,
    'L': Vec.left,
    'R': Vec.right,
  };

  Iterable<Iterable<Vec>> wirePaths(String input) => input.lines.map((line) =>
      line.split(',').map((v) => _dirVec2s[v[0]]! * int.parse(v.substring(1))));

  Iterable<Line> segmentsFrom(Vec origin, Iterable<Vec> path) {
    final segments = <Line>[];
    for (final p in path) {
      final end = origin + p;
      segments.add(Line(origin, end));
      origin = end;
    }
    return segments;
  }

  num distanceTo(Vec intersection, Iterable<Line> path) {
    var distance = 0;
    for (final segment in path) {
      final distanceAlong = segment.distanceAlong(intersection);
      if (distanceAlong != null) {
        return distance + distanceAlong;
      }
      distance += segment.manhattanDistance.toInt();
    }
    throw Exception('Point $intersection is not on path $path');
  }
}
