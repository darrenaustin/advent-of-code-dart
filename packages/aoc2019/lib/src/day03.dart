// https://adventofcode.com/2019/day/3

import 'package:aoc/aoc.dart';

main() => Day03().solve();

class Day03 extends AdventDay {
  Day03() : super(
    2019, 3, name: '',
  );

  @override
  dynamic part1(String input) => 'Need to migrate';

  @override
  dynamic part2(String input) => 'Need to migrate';
}

// https://adventofcode.com/2019/day/3
// 
// import 'package:aoc/aoc.dart';
// import 'package:aoc/util/vec2.dart';
// import 'package:collection/collection.dart';
// 
// class Day03 extends AdventDay {
//   Day03() : super(2019, 3, solution1: 1626, solution2: 27330);
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