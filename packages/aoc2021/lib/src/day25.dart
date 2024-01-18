// https://adventofcode.com/2021/day/25

import 'package:aoc/aoc.dart';
import 'package:aoc/util/grid2.dart';
import 'package:aoc/util/string.dart';
import 'package:aoc/util/vec.dart';

main() => Day25().solve();

class Day25 extends AdventDay {
  Day25() : super(2021, 25, name: 'Sea Cucumber');

  @override
  dynamic part1(String input) {
    final grid = parseGrid(input);
    int steps = 1;
    while (step(grid) != 0) {
      steps++;
    }
    return steps;
  }

  @override
  dynamic part2(String input) => AdventDay.lastStarSolution;

  int step(Grid<String> grid) {
    Vec eastOf(Vec l) => Vec((l.x + 1) % grid.width, l.y);
    Vec southOf(Vec l) => Vec(l.x, (l.y + 1) % grid.height);

    final eastMoves = grid
        .locationsWhere((c) => c == '>')
        .where((l) => grid.cell(eastOf(l)) == '.')
        .toList();
    for (final loc in eastMoves) {
      grid.setCell(loc, '.');
      grid.setCell(eastOf(loc), '>');
    }
    final southMoves = grid
        .locationsWhere((c) => c == 'v')
        .where((l) => grid.cell(southOf(l)) == '.')
        .toList();
    for (final loc in southMoves) {
      grid.setCell(loc, '.');
      grid.setCell(southOf(loc), 'v');
    }
    return eastMoves.length + southMoves.length;
  }

  Grid<String> parseGrid(String input) =>
      Grid.from(input.lines.map((l) => l.chars.toList()).toList(), '.');
}
