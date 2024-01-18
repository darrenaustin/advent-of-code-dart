// https://adventofcode.com/2021/day/25

import 'package:aoc/aoc.dart';
import 'package:aoc/util/grid.dart';
import 'package:aoc/util/vec.dart';

main() => Day25().solve();

class Day25 extends AdventDay {
  Day25() : super(2021, 25, name: 'Sea Cucumber');

  @override
  dynamic part1(String input) {
    final grid = Grid.parse(input);
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
        .locationsWhereValue((c) => c == '>')
        .where((l) => grid.value(eastOf(l)) == '.')
        .toList();
    for (final loc in eastMoves) {
      grid.setValue(loc, '.');
      grid.setValue(eastOf(loc), '>');
    }
    final southMoves = grid
        .locationsWhereValue((c) => c == 'v')
        .where((l) => grid.value(southOf(l)) == '.')
        .toList();
    for (final loc in southMoves) {
      grid.setValue(loc, '.');
      grid.setValue(southOf(loc), 'v');
    }
    return eastMoves.length + southMoves.length;
  }
}
