// https://adventofcode.com/2021/day/25

import 'package:advent_of_code_dart/src/util/vec2.dart';

import '../../day.dart';
import '../util/grid2.dart';

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
    return 'got em all';
  }

  int step(Grid<String> grid) {
    Vec2 eastOf(Vec2 l) => Vec2((l.x + 1) % grid.width, l.y);
    Vec2 southOf(Vec2 l) => Vec2(l.x, (l.y + 1) % grid.height);

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
