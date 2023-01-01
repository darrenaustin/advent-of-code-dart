// https://adventofcode.com/2019/day/11

import 'package:aoc/aoc.dart';

main() => Day11().solve();

class Day11 extends AdventDay {
  Day11() : super(
    2019, 11, name: '',
  );

  @override
  dynamic part1(String input) => 'Need to migrate';

  @override
  dynamic part2(String input) => 'Need to migrate';
}

// https://adventofcode.com/2019/day/11
// 
// import 'package:aoc/aoc.dart';
// import 'package:aoc/util/sparse_grid.dart';
// import 'package:aoc/util/vec2.dart';
// 
// import 'intcode.dart';
// 
// class Day11 extends AdventDay {
//   Day11() : super(2019, 11, solution1: 1686, solution2: 'GARPKZUL');
// 
//   static Map<Vec2, Vec2> rotateLeft = {
//     Vec2.up: Vec2.left,
//     Vec2.down: Vec2.right,
//     Vec2.left: Vec2.down,
//     Vec2.right: Vec2.up,
//   };
// 
//   static Map<Vec2, Vec2> rotateRight = {
//     Vec2.up: Vec2.right,
//     Vec2.down: Vec2.left,
//     Vec2.left: Vec2.up,
//     Vec2.right: Vec2.down,
//   };
// 
//   static const String black = ' ';
//   static const String white = '\u2588'; // '#';
// 
//   @override
//   dynamic part1() {
//     final machine = Intcode.from(program: inputData());
//     final hull = SparseGrid<String>(defaultValue: black);
//     var location = Vec2.zero;
//     var direction = Vec2.up;
//     machine.input.add(hull.cell(location) == black ? 0 : 1);
//     while (!machine.execute()) {
//       final paint = machine.output.removeAt(0);
//       hull.setCell(location, paint == 0 ? black : white);
//       final rotate = machine.output.removeAt(0);
//       direction = rotate == 0 ? rotateLeft[direction]! : rotateRight[direction]!;
//       location += direction;
//       machine.input.add(hull.cell(location) == black ? 0 : 1);
//     }
//     return hull.numSetCells();
//   }
// 
//   @override
//   dynamic part2() {
//     final machine = Intcode.from(program: inputData());
//     final hull = SparseGrid<String>(defaultValue: black);
//     var location = Vec2.zero;
//     var direction = Vec2.up;
//     machine.input.add(1);
//     while (!machine.execute()) {
//       final paint = machine.output.removeAt(0);
//       hull.setCell(location, paint == 0 ? black : white);
//       final rotate = machine.output.removeAt(0);
//       direction = rotate == 0 ? rotateLeft[direction]! : rotateRight[direction]!;
//       location = location + direction;
//       machine.input.add(hull.cell(location) == black ? 0 : 1);
//     }
//     // TODO: look into OCR to parse the text from the ascii generated below?
//     // After inspecting output, sigh:
//     print(hull);
//     return 'GARPKZUL';
//   }
// }
// 