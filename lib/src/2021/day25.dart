// https://adventofcode.com/2021/day/25

import 'package:advent_of_code_dart/src/util/grid.dart';

import '../../day.dart';

class Day25 extends AdventDay {
  Day25() : super(2021, 25, solution1: 453);

  @override
  dynamic part1() {
    final grid = inputGrid();
    int steps = 1;
    while (step(grid) != 0) {
      steps++;
    }
    return steps;
  }

  @override
  dynamic part2() {
    return null;
  }

  int step(Grid<String> grid) {
    Loc eastOf(Loc l) => Loc((l.x + 1) % grid.width, l.y);
    Loc southOf(Loc l) => Loc(l.x, (l.y + 1) % grid.height);

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

  Grid<String> inputGrid() {
    return Grid.from(inputDataLines().map((l) => l.split('').toList()).toList(), '.');
  }
}
