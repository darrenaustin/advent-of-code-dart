// https://adventofcode.com/2020/day/3

import 'package:aoc/aoc.dart';
import 'package:aoc/util/collection.dart';
import 'package:aoc/util/grid2.dart';
import 'package:aoc/util/string.dart';
import 'package:aoc/util/vec.dart';

main() => Day03().solve();

class Day03 extends AdventDay {
  Day03() : super(2020, 3, name: 'Toboggan Trajectory');

  @override
  dynamic part1(String input) => treesHit(parseGrid(input), Vec(3, 1));

  @override
  dynamic part2(String input) {
    final grid = parseGrid(input);
    final slopes = [Vec(1, 1), Vec(3, 1), Vec(5, 1), Vec(7, 1), Vec(1, 2)];
    return slopes.map((slope) => treesHit(grid, slope)).product;
  }

  Grid<String> parseGrid(String input) {
    final lines = input.lines.map((line) => line.chars.toList()).toList();
    return Grid.from(lines, '.');
  }

  int treesHit(Grid<String> grid, Vec slope) {
    int numTreesHit = 0;
    Vec position = Vec.zero;

    while (position.y < grid.height) {
      if (grid.cell(position) == '#') {
        numTreesHit++;
      }
      position = Vec((position.x + slope.x) % grid.width, position.y + slope.y);
    }
    return numTreesHit;
  }
}
