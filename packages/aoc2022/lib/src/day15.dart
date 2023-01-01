// https://adventofcode.com/2022/day/15

import 'package:aoc/aoc.dart';

main() => Day15().solve();

class Day15 extends AdventDay {
  Day15() : super(
    2022, 15, name: '',
  );

  @override
  dynamic part1(String input) => 'Need to migrate';

  @override
  dynamic part2(String input) => 'Need to migrate';
}

// https://adventofcode.com/2022/day/15
// 
// import 'dart:math';
// 
// import 'package:aoc/aoc.dart';
// import 'package:aoc/util/collection.dart';
// import 'package:aoc/util/vec2.dart';
// 
// class Day15 extends AdventDay {
//   Day15() : super(2022, 15, solution1: 5125700, solution2: 11379394658764);
// 
//   @override
//   dynamic part1() {
//     final sensors = inputSensors();
// 
//     int minX = 0;
//     int maxX = 0;
//     for (final s in sensors) {
//       minX = min(minX, s.pos.xInt - s.distance);
//       maxX = max(maxX, s.pos.xInt + s.distance);
//     }
// 
//     bool noBeacon(Vec2 p) =>
//       sensors.any((s) =>
//         p != s.beacon &&
//         s.pos.manhattanDistanceTo(p) <= s.distance
//       );
// 
//     final row = 2000000;
//     return range(minX, maxX + 1)
//       .map((col) => Vec2.int(col, row))
//       .where(noBeacon)
//       .length;
//   }
// 
//   @override
//   dynamic part2() {
//     final sensors = inputSensors();
//     final minGrid = 0;
//     final maxGrid = 4000000;
//     final diamondDirs = [Vec2(-1, -1), Vec2(-1, 1), Vec2(1, -1), Vec2(1, 1)];
// 
//     // Given that there is only one beacon that isn't seen by all sensors
//     // in the grid, it must be at most sensor.distance+1 from all sensors.
//     // If there was a beacon at more then that, then there would be more than
//     // one option. So we just need to check the diamond+1 perimeter of each
//     // sensor.
//     for (final sensor in sensors) {
//       final distance = sensor.distance;
//       for (final dir in diamondDirs)  {
//         for (int dx = 0; dx <= distance; dx++) {
//           final dy = distance - dx + 1;
//           final x = sensor.pos.x + dir.x * dx;
//           final y = sensor.pos.y + dir.y * dy;
//           if (minGrid <= x && x <= maxGrid && minGrid <= y && y <= maxGrid) {
//             final p = Vec2(x, y);
//             if (!sensors.any((s) => s.pos.manhattanDistanceTo(p) <= s.distance)) {
//               return p.xInt * 4000000 + p.yInt;
//             }
//           }
//         }
//       }
//     }
//   }
// 
//   List<Sensor> inputSensors() {
//     final sensorPattern = RegExp(r'Sensor at x=(-?\d+), y=(-?\d+): closest beacon is at x=(-?\d+), y=(-?\d+)');
//     final List<Sensor> sensors = [];
//     for (final line in inputDataLines()) {
//       final match = sensorPattern.firstMatch(line)!;
//       final Vec2 pos = Vec2.int(int.parse(match.group(1)!), int.parse(match.group(2)!));
//       final Vec2 beacon = Vec2.int(int.parse(match.group(3)!), int.parse(match.group(4)!));
//       sensors.add(Sensor(pos, beacon));
//     }
//     return sensors;
//   }
// }
// 
// class Sensor {
//   Sensor(this.pos, this.beacon) {
//     distance = pos.manhattanDistanceTo(beacon).toInt();
//   }
// 
//   final Vec2 pos;
//   final Vec2 beacon;
//   late final int distance;
// }
// 