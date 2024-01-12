// https://adventofcode.com/2023/day/21

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';

main() => Day21().solve();

class Day21 extends AdventDay {
  Day21() : super(2023, 21, name: 'Step Counter');

  @override
  dynamic part1(String input, [int numSteps = 64]) {
    final g = Garden(input);
    return numPlotsFrom(g, g.start, [numSteps])[0];
  }

  @override
  dynamic part2(String input, [int numSteps = 26501365]) {
    final g = Garden(input);

    // If the remainder of steps after handling all the grid width's
    // is half the grid width (which is where we start from), and
    // every cell in the row or column of the start is empty, then
    // we can use the quadratic interpolation below.
    if (numSteps % g.width != g.width ~/ 2 || !openToEdges(g)) {
      // Just use the regular brute force.
      return numPlotsFrom(g, g.start, [numSteps])[0];
    }

    // There are open paths from the start location to each edge of the grid,
    // so every half grid size steps we will hit each of the repeated grids
    // in each direction. Therefore the number of positions will grow in
    // a quadratic amount based on the size of the grid.

    // First we compute three steps at: half-width, half-width + width,
    // half-width + 2 * width. Then we can use these as the three cooeffients
    // in the quadratic interpolation to get the final number of steps.
    final halfWidth = g.width ~/ 2;
    final [a0, a1, a2] = numPlotsFrom(
        g, g.start, [halfWidth, halfWidth + g.width, halfWidth + 2 * g.width]);

    final n = numSteps ~/ g.width;
    final b0 = a0;
    final b1 = a1 - a0;
    final b2 = a2 - a1;
    return b0 + b1 * n + (n * (n - 1) ~/ 2) * (b2 - b1);
  }

  List<int> numPlotsFrom(Garden g, (int, int) start, List<int> numSteps) {
    final results = <int>[];
    final visited = <(int, int)>{};
    final numPlots = [0, 0];
    int walked = 0;
    var outerSteps = {start};
    for (final numStep in numSteps) {
      while (walked <= numStep) {
        final nextSteps = <(int, int)>{};
        for (final s in outerSteps) {
          if (!visited.add(s)) {
            continue;
          }
          numPlots[walked % 2]++;
          nextSteps
              .addAll(g.plotNeighbors(s).where((p) => !visited.contains(p)));
        }
        outerSteps = nextSteps;
        walked++;
      }
      results.add(numPlots[numStep % 2]);
    }
    return results;
  }

  bool openToEdges(Garden g) {
    // Is there a open path to the left, right, top and bottom edges from the
    // start position?
    assert(g.width == g.height);
    final (startX, startY) = g.start;
    for (int i = 0; i < g.width; i++) {
      if (!g.plot((startX, i)) || !g.plot((i, startY))) {
        return false;
      }
    }
    return true;
  }
}

class Garden {
  Garden(String input) {
    final data = input.lines.map((l) => l.chars).toList();
    width = data[0].length;
    height = data.length;
    _grid = List.generate(
        height,
        (y) => List.generate(width, (x) {
              final value = data[y][x];
              if (value == 'S') {
                start = (x, y);
              }
              return value != '#';
            }));
  }

  late final List<List<bool>> _grid;
  late final (int, int) start;
  late final int width;
  late final int height;

  static final _dirs = [(0, -1), (0, 1), (1, 0), (-1, 0)];

  bool plot(final (int, int) p) => _grid[p.$2 % height][p.$1 % width];

  Set<(int, int)> plotNeighbors(final (int, int) pos) => _dirs
      .map((d) => (pos.$1 + d.$1, pos.$2 + d.$2))
      .where((p) => plot(p))
      .toSet();
}
