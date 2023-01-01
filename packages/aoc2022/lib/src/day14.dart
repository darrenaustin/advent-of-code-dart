// https://adventofcode.com/2022/day/14

import 'package:aoc/aoc.dart';

main() => Day14().solve();

class Day14 extends AdventDay {
  Day14() : super(
    2022, 14, name: '',
  );

  @override
  dynamic part1(String input) => 'Need to migrate';

  @override
  dynamic part2(String input) => 'Need to migrate';
}

// https://adventofcode.com/2022/day/14
// 
// import 'package:aoc/aoc.dart';
// import 'package:aoc/util/sparse_grid.dart';
// import 'package:aoc/util/vec2.dart';
// 
// class Day14 extends AdventDay {
//   Day14() : super(2022, 14, solution1: 610, solution2: 27194);
// 
//   @override
//   dynamic part1() => (SandMap(inputDataLines())..dropAllSand()).numSand();
// 
//   @override
//   dynamic part2() => (SandMap(inputDataLines(), floor: true)..dropAllSand()).numSand();
// }
// 
// class SandMap {
// 
//   static final sand = 'o';
//   static final rock = '#';
//   static final space = ' ';
//   static final sandSource = Vec2(500, 0);
//   static final dropDirections = [Vec2.down, Vec2.downLeft, Vec2.downRight];
// 
//   SandMap(List<String> rockData, { bool floor = false })
//     : _grid = SparseGrid<String>(defaultValue: space) {
//     for (final line in rockData) {
//       final rockPath = line
//         .split(' -> ')
//         .map((p) => p.split(','))
//         .map((v) => Vec2(double.parse(v.first), double.parse(v.last)));
//       _drawPath(rockPath, rock);
//     }
//     _floor = floor ? _grid.maxLocation.y + 2 : null;
//   }
// 
//   final SparseGrid<String> _grid;
//   late final double? _floor;
// 
//   void dropAllSand() {
//     while (!dropSand(sandSource)) {}
//   }
// 
//   bool dropSand(Vec2 from) {
//     if (_grid.cell(from) != space) {
//       // Source is covered, so we are done.
//       return true;
//     }
//     final dropSpots = dropDirections.map((d) => d + from);
//     for (final spot in dropSpots) {
//       if (_floor == null && spot.y > _grid.maxLocation.y) {
//         // Falls forever
//         return true;
//       }
//       final spotContents = spot.y < (_floor ?? double.infinity)
//         ? _grid.cell(spot)
//         : rock;
//       if (spotContents == space) {
//         return dropSand(spot);
//       }
//     }
//     // Can't go any further, so it lands here
//     _grid.setCell(from, sand);
//     return false;
//   }
// 
//   int numSand() => _grid.numSetCellsWhere((p) => p == sand);
// 
//   void _drawPath(Iterable<Vec2> path, String value) {
//     Vec2 current = path.first;
//     for (final dest in path.skip(1)) {
//       _drawLine(current, dest, rock);
//       current = dest;
//     }
//   }
// 
//   void _drawLine(Vec2 from, Vec2 to, String value) {
//     final diff = to - from;
//     final delta = Vec2(diff.x.sign, diff.y.sign);
//     for (Vec2 current = from; current != to; current += delta) {
//       _grid.setCell(current, value);
//     }
//     _grid.setCell(to, value);
//   }
// }
// 