// https://adventofcode.com/2021/day/11

import 'package:aoc/aoc.dart';

main() => Day11().solve();

class Day11 extends AdventDay {
  Day11() : super(
    2021, 11, name: '',
  );

  @override
  dynamic part1(String input) => 'Need to migrate';

  @override
  dynamic part2(String input) => 'Need to migrate';
}

// https://adventofcode.com/2021/day/11
// 
// import 'package:aoc/aoc.dart';
// import 'package:aoc/util/grid2.dart';
// import 'package:aoc/util/vec2.dart';
// 
// class Day11 extends AdventDay {
//   Day11() : super(2021, 11, solution1: 1562, solution2: 268);
// 
//   @override
//   dynamic part1() {
//     final grid = inputGrid();
//     int numFlashes = 0;
//     for (int i = 0; i < 100; i++) {
//       numFlashes += stepGrid(grid).length;
//     }
//     return numFlashes;
//   }
// 
//   @override
//   dynamic part2() {
//     final grid = inputGrid();
//     int step = 0;
//     while (!grid.cells().every((v) => v == 0)) {
//       stepGrid(grid);
//       step++;
//     }
//     return step;
//   }
// 
//   Iterable<Vec2> stepGrid(Grid<int> grid) {
//     grid.updateCells((v) => v + 1);
//     final flashes = <Vec2>{};
//     final needFlashes = grid.locationsWhere((v) => v > 9).toList();
//     while (needFlashes.isNotEmpty) {
//       final flash = needFlashes.removeLast();
//       if (!flashes.contains(flash)) {
//         flashes.add(flash);
//         for (final neighbor in grid.neighborLocations(flash)) {
//           final updatedEnergy = grid.cell(neighbor) + 1;
//           grid.setCell(neighbor, updatedEnergy);
//           if (updatedEnergy > 9 && !flashes.contains(neighbor)) {
//             needFlashes.add(neighbor);
//           }
//         }
//       }
//     }
//     for (final flash in flashes) {
//       grid.setCell(flash, 0);
//     }
//     return flashes;
//   }
// 
//   Grid<int> inputGrid() {
//     final List<List<int>> nums = inputDataLines()
//         .map((l) => l.split('')
//         .map((n) => int.parse(n)).toList()
//     ).toList();
//     final Grid<int> grid = Grid(nums[0].length, nums.length, 0);
//     for (int y = 0; y < grid.height; y++) {
//       for (int x = 0; x < grid.width; x++) {
//         grid.setCell(Vec2.int(x, y), nums[y][x]);
//       }
//     }
//     return grid;
//   }
// }
// 