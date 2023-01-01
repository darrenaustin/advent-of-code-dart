// https://adventofcode.com/2016/day/3

import 'package:aoc/aoc.dart';

main() => Day03().solve();

class Day03 extends AdventDay {
  Day03() : super(
    2016, 3, name: '',
  );

  @override
  dynamic part1(String input) => 'Need to migrate';

  @override
  dynamic part2(String input) => 'Need to migrate';
}

// https://adventofcode.com/2016/day/3
// 
// import 'package:aoc/aoc.dart';
// import 'package:collection/collection.dart';
// 
// class Day03 extends AdventDay {
//   Day03() : super(2016, 3, solution1: 993, solution2: 1849);
// 
//   @override
//   dynamic part1() {
//     return inputTriangles()
//       .where(validTriangle)
//       .length;
//   }
// 
//   @override
//   dynamic part2() {
//     return inputVerticalTriangles()
//       .where(validTriangle)
//       .length;
//   }
// 
//   bool validTriangle(Iterable<int> vertices) {
//     List<int> sorted = List.from(vertices)..sort();
//     return sorted[0] + sorted[1] > sorted[2];
//   }
// 
//   Iterable<int> parseNumbers(String s) {
//     return s
//       .trim()
//       .split(RegExp(r'\W+'))
//       .map((n) => int.parse(n));
//   }
// 
//   Iterable<Iterable<int>> inputTriangles() {
//     return inputDataLines().map(parseNumbers);
//   }
// 
//   Iterable<Iterable<int>> inputVerticalTriangles() {
//     // Break the input into 3 line groups and then
//     // parse the numbers and map the columns to rows for
//     // the triangles.
//     return inputDataLines().slices(3).map((group) {
//       final rows = group.map((line) => parseNumbers(line).toList()).toList();
//       return [
//         [rows[0][0], rows[1][0], rows[2][0]],
//         [rows[0][1], rows[1][1], rows[2][1]],
//         [rows[0][2], rows[1][2], rows[2][2]],
//       ];
//     }).flattened;
//   }
// }
// 