// https://adventofcode.com/2023/day/11

import 'dart:math';

import 'package:aoc/aoc.dart';
import 'package:aoc/util/math.dart';
import 'package:aoc/util/string.dart';

main() => Day11().solve();

class Day11 extends AdventDay {
  Day11() : super(2023, 11, name: '');

  @override
  dynamic part1(String input) => sumGalaxyDistances(input, 2);

  @override
  dynamic part2(String input, [int expansion = 1000000]) =>
      sumGalaxyDistances(input, expansion);

  // My original solution worked, but was very slow due to a quadratic
  // pair-wise calulation at the end. Inspired by the clever insight from:
  //
  // http://clb.confined.space/aoc2023/#day11
  //
  // I was able to get this down from ~1450ms to ~2ms by breaking up the
  // distance between galaxies into seperate calculations for the x and
  // y components. This way we only needed to keep an array of the number of
  // galaxies in each row or column and then walk through those computing
  // agregate distances. Unlike his, mine is still quadratic in the width and
  // height of the grid, but that is still much faster than quadratic in the
  // number of galaxies.

  int sumGalaxyDistances(String input, int expansionFactor) {
    final gridData = input.lines.map((l) => l.chars).toList();
    final width = gridData[0].length;
    final height = gridData.length;
    var galaxiesInCol = List<int>.generate(width, (_) => 0);
    var galaxiesInRow = List<int>.generate(height, (_) => 0);
    int numGalaxies = 0;
    var (firstCol, lastCol) = (maxInt, 0);
    var (firstRow, lastRow) = (maxInt, 0);
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final value = gridData[y][x];
        if (value == '#') {
          numGalaxies++;
          galaxiesInCol[x]++;
          galaxiesInRow[y]++;
          (firstCol, lastCol) = (min(firstCol, x), max(lastCol, x));
        }
        if (galaxiesInRow[y] != 0) {
          (firstRow, lastRow) = (min(firstRow, x), max(lastRow, x));
        }
      }
    }
    galaxiesInCol = galaxiesInCol.sublist(firstCol, lastCol + 1);
    galaxiesInRow = galaxiesInRow.sublist(firstRow, lastRow + 1);

    return sumPairDistances(galaxiesInCol, numGalaxies, expansionFactor - 1) +
        sumPairDistances(galaxiesInRow, numGalaxies, expansionFactor - 1);
  }

  int sumPairDistances(List<int> galaxies, int totalGalaxies, int expandBy) {
    int distance = 0;
    for (int i = 0; i < galaxies.length; i++) {
      if (galaxies[i] == 0) {
        continue;
      }
      int expandedSpace = 0;
      for (int j = i + 1; j < galaxies.length; j++) {
        if (galaxies[j] == 0) {
          expandedSpace += expandBy;
        } else {
          distance += galaxies[i] * galaxies[j] * (j - i + expandedSpace);
        }
      }
    }
    return distance;
  }
}
