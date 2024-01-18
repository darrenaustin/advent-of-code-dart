// https://adventofcode.com/2021/day/5

import 'package:aoc/aoc.dart';
import 'package:aoc/util/sparse_grid.dart';
import 'package:aoc/util/string.dart';
import 'package:aoc/util/vec2.dart';

main() => Day05().solve();

class Day05 extends AdventDay {
  Day05() : super(2021, 5, name: 'Hydrothermal Venture');

  @override
  dynamic part1(String input) =>
      numHotSpots(parseVents(input).where((v) => v.isOrthogonal));

  @override
  dynamic part2(String input) => numHotSpots(parseVents(input));

  Iterable<LineSegment2> parseVents(String input) => input.lines.map((s) {
        final nums = s.split(RegExp(r'\D+')).map(double.parse).toList();
        return LineSegment2(Vec2(nums[0], nums[1]), Vec2(nums[2], nums[3]));
      });

  int numHotSpots(Iterable<LineSegment2> vents) {
    final grid = SparseGrid<int>(defaultValue: 0);
    for (final vent in vents) {
      for (final p in vent.discretePointsAlong()) {
        grid.setCell(p, grid.cell(p) + 1);
      }
    }
    return grid.numSetCellsWhere((count) => count >= 2);
  }
}
