// https://adventofcode.com/2019/day/3

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:aoc/util/vec.dart';
import 'package:collection/collection.dart';

main() => Day03().solve();

class Day03 extends AdventDay {
  Day03() : super(2019, 3, name: 'Crossed Wires');

  @override
  dynamic part1(String input) {
    final origin = Vec2.zero;
    final wireSegments = wirePaths(input).map((p) => segmentsFrom(origin, p));
    final wire1 = wireSegments.first;
    final wire2 = wireSegments.last;

    final intersections = <Vec2>{};
    for (final s1 in wire1) {
      intersections
          .addAll(wire2.map((s2) => s1.intersection(s2)).whereNotNull());
    }
    intersections.remove(origin);
    return intersections.map((v) => v.manhattanDistanceTo(origin)).min.toInt();
  }

  @override
  dynamic part2(String input) {
    final origin = Vec2.zero;
    final wireSegments = wirePaths(input).map((p) => segmentsFrom(origin, p));
    final wire1 = wireSegments.first;
    final wire2 = wireSegments.last;

    final intersections = <Vec2>{};
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
    'U': Vec2.up,
    'D': Vec2.down,
    'L': Vec2.left,
    'R': Vec2.right,
  };

  Iterable<Iterable<Vec2>> wirePaths(String input) => input.lines.map((line) =>
      line.split(',').map((v) => _dirVec2s[v[0]]! * int.parse(v.substring(1))));

  Iterable<LineSegment2> segmentsFrom(Vec2 origin, Iterable<Vec2> path) {
    final segments = <LineSegment2>[];
    for (final p in path) {
      final end = origin + p;
      segments.add(LineSegment2(origin, end));
      origin = end;
    }
    return segments;
  }

  double distanceTo(Vec2 intersection, Iterable<LineSegment2> path) {
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

// https://adventofcode.com/2019/day/3
//
// import 'package:aoc/aoc.dart';
// import 'package:aoc/util/vec.dart';
// import 'package:collection/collection.dart';
//
// class Day03 extends AdventDay {
//   Day03() : super(2019, 3);
//
//   @override
//   dynamic part1() {
//     final origin = Vec2.zero;
//     final wireSegments = inputWirePaths().map((p) => segmentsFrom(origin, p));
//     final wire1 = wireSegments.first;
//     final wire2 = wireSegments.last;
//
//     final intersections = <Vec2>{};
//     for (final s1 in wire1) {
//       intersections.addAll(
//         wire2.map((s2) => s1.intersection(s2)).whereNotNull()
//       );
//     }
//     intersections.remove(origin);
//     return intersections.map((v) => v.manhattanDistanceTo(origin)).min.toInt();
//   }
//
//   @override
//   dynamic part2() {
//     final origin = Vec2.zero;
//     final wireSegments = inputWirePaths().map((p) => segmentsFrom(origin, p));
//     final wire1 = wireSegments.first;
//     final wire2 = wireSegments.last;
//
//     final intersections = <Vec2>{};
//     for (final s1 in wire1) {
//       intersections.addAll(
//           wire2.map((s2) => s1.intersection(s2)).whereNotNull()
//       );
//     }
//     intersections.remove(origin);
//     return intersections
//       .map((v) => distanceTo(v, wire1) + distanceTo(v, wire2))
//       .min
//       .toInt();
//   }
//
//   static final _dirVec2s = {
//     'U': const Vec2( 0,  1),
//     'D': const Vec2( 0, -1),
//     'L': const Vec2(-1,  0),
//     'R': const Vec2( 1,  0),
//   };
//
//   Iterable<Iterable<Vec2>> inputWirePaths() {
//     return inputDataLines().map((line) {
//       return line.split(',').map((v) {
//         return _dirVec2s[v[0]]! * int.parse(v.substring(1));
//       });
//     });
//   }
//
//   Iterable<LineSegment> segmentsFrom(Vec2 origin, Iterable<Vec2> path) {
//     final segments = <LineSegment>[];
//     for (final p in path) {
//       final end = origin + p;
//       segments.add(LineSegment(origin, end));
//       origin = end;
//     }
//     return segments;
//   }
//
//   double distanceTo(Vec2 intersection, Iterable<LineSegment> path) {
//     var distance = 0;
//     for (final segment in path) {
//       final distanceAlong = segment.distanceAlong(intersection);
//       if (distanceAlong != null) {
//         return distance + distanceAlong;
//       }
//       distance += segment.manhattanDistance.toInt();
//     }
//     throw Exception('Point $intersection is not on path $path');
//   }
// }
//
