// https://adventofcode.com/2021/day/2

import 'package:aoc/aoc.dart';

main() => Day02().solve();

class Day02 extends AdventDay {
  Day02() : super(
    2021, 2, name: '',
  );

  @override
  dynamic part1(String input) => 'Need to migrate';

  @override
  dynamic part2(String input) => 'Need to migrate';
}

// https://adventofcode.com/2021/day/2
// 
// import 'package:aoc/aoc.dart';
// import 'package:aoc/util/vec2.dart';
// 
// class Day02 extends AdventDay {
//   Day02() : super(2021, 2, solution1: 1484118, solution2: 1463827010);
// 
//   @override
//   dynamic part1() {
//     final destination = inputDirections().reduce((a, b) => a + b);
//     return destination.x * destination.y;
//   }
// 
//   @override
//   dynamic part2() {
//     final directions = inputDirections();
//     Vec2 destination = Vec2.zero;
//     double aim = 0;
//     for (final direction in directions) {
//       destination += Vec2(direction.x, aim * direction.x);
//       aim += direction.y;
//     }
//     return destination.x * destination.y;
//   }
// 
//   List<Vec2> inputDirections() {
//     const directionsVec2 = {
//       'forward': Vec2.right,
//       'up': Vec2.up,
//       'down': Vec2.down,
//     };
//     final lines = inputDataLines();
//     final directions = <Vec2>[];
//     for (final line in lines) {
//       final parts = line.split(' ');
//       final direction = parts[0];
//       final units = int.parse(parts[1]);
//       directions.add(directionsVec2[direction]! * units);
//     }
//     return directions;
//   }
// }
// 