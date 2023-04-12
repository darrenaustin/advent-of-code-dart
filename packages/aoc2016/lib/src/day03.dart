// https://adventofcode.com/2016/day/3

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day03().solve();

class Day03 extends AdventDay {
  Day03() : super(2016, 3, name: 'Squares With Three Sides');

  @override
  dynamic part1(String input) => triangles(input).where(validTriangle).length;

  @override
  dynamic part2(String input) => verticalTriangles(input).where(validTriangle).length;

  bool validTriangle(Iterable<int> vertices) {
    List<int> sorted = List.from(vertices)..sort();
    return sorted[0] + sorted[1] > sorted[2];
  }

  Iterable<int> parseNumbers(String s) =>
    s.trim().split(RegExp(r'\W+')).map((n) => int.parse(n));

  Iterable<Iterable<int>> triangles(String input) => 
    input.lines.map(parseNumbers);

  Iterable<Iterable<int>> verticalTriangles(String input) {
    // Break the input into 3 line groups and then
    // parse the numbers and map the columns to rows for
    // the triangles.
    return input.lines.slices(3).map((group) {
      final rows = group.map((line) => parseNumbers(line).toList()).toList();
      return [
        [rows[0][0], rows[1][0], rows[2][0]],
        [rows[0][1], rows[1][1], rows[2][1]],
        [rows[0][2], rows[1][2], rows[2][2]],
      ];
    }).flattened;
  }
}
