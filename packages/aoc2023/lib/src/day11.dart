// https://adventofcode.com/2023/day/11

import 'package:aoc/aoc.dart';
import 'package:aoc/util/collection.dart';
import 'package:aoc/util/combinatorics.dart';
import 'package:aoc/util/string.dart';
import 'package:aoc/util/vec.dart';
import 'package:collection/collection.dart';

main() => Day11().solve();

class Day11 extends AdventDay {
  Day11() : super(2023, 11, name: '');

  @override
  dynamic part1(String input) => sumGalaxyDistances(input, 2);

  @override
  dynamic part2(String input, [int expansion = 1000000]) =>
      sumGalaxyDistances(input, expansion);

  int sumGalaxyDistances(String input, int expansionFactor) {
    final gridData = input.lines.map((l) => l.chars).toList();
    final width = gridData[0].length;
    final height = gridData.length;
    final galaxies = <Vec2>[];
    final emptyCols = range(width).toSet();
    final emptyRows = range(width).toSet();
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final value = gridData[y][x];
        if (value != '.') {
          galaxies.add(Vec2.int(x, y));
          emptyCols.remove(x);
          emptyRows.remove(y);
        }
      }
    }

    // Expand empty rows and columns.
    final increaseBy = expansionFactor - 1;
    for (int g = 0; g < galaxies.length; g++) {
      final emptyColsBefore =
          emptyCols.takeWhile((c) => c <= galaxies[g].x).length;
      final emptyRowsBefore =
          emptyRows.takeWhile((r) => r <= galaxies[g].y).length;
      galaxies[g] = galaxies[g] +
          Vec2.int(emptyColsBefore * increaseBy, emptyRowsBefore * increaseBy);
    }

    // Compute the distances and sum them.
    return combinations(galaxies, 2)
        .map((vs) => vs.first.manhattanDistanceTo(vs.last))
        .sum
        .toInt();
  }
}
