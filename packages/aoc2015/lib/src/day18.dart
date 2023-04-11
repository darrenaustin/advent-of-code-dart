// https://adventofcode.com/2015/day/18

import 'package:aoc/aoc.dart';
import 'package:aoc/util/collection.dart';
import 'package:aoc/util/grid2.dart';
import 'package:aoc/util/string.dart';
import 'package:aoc/util/vec.dart';

main() => Day18().solve();

class Day18 extends AdventDay {
  Day18() : super(
    2015, 18, name: 'Like a GIF For Your Yard',
    solution1: 821, solution2: 886,
  );

  @override
  dynamic part1(String input, [int steps = 100]) =>
    iterate(animate, lightGrid(input))
      .elementAt(steps)
      .cellsWhere(lightOn)
      .length;

  @override
  dynamic part2(String input, [int steps = 100]) =>
    iterate(cornersOnAnimate, turnCornersOn(lightGrid(input)))
      .elementAt(steps)
      .cellsWhere(lightOn)
      .length;

  static Grid<String> lightGrid(String input) =>
    Grid.from(input.lines.map((s) => s.chars).toList(), '.');

  static bool lightOn(String l) => l == '#';

  static Grid<String> animate(Grid<String> lights) {
    final nextLights = Grid.emptyFrom(lights);
    for (final loc in lights.locations()) {
      final bool on = lightOn(lights.cell(loc));
      final int neighborsOn = lights.neighbors(loc).where(lightOn).length;
      if (on && (neighborsOn == 2 || neighborsOn == 3)) {
        nextLights.setCell(loc, '#');
      } else if (!on && neighborsOn == 3) {
        nextLights.setCell(loc, '#');
      }
    }
    return nextLights;
  }

  static Grid<String> cornersOnAnimate(Grid<String> lights) =>
    turnCornersOn(animate(lights));

  static Grid<String> turnCornersOn(Grid<String> lights) {
    lights.setCell(Vec2.zero, '#');
    lights.setCell(Vec2(lights.width - 1, 0), '#');
    lights.setCell(Vec2(0, lights.height - 1), '#');
    lights.setCell(Vec2(lights.width - 1, lights.height - 1), '#');
    return lights;
  }
}
