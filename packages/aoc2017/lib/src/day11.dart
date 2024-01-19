// https://adventofcode.com/2017/day/11

import 'dart:math';

import 'package:aoc/aoc.dart';
import 'package:aoc/util/vec3.dart';

main() => Day11().solve();

class Day11 extends AdventDay {
  Day11() : super(2017, 11, name: 'Hex Ed');

  @override
  dynamic part1(String input) {
    Vec3 pos = Vec3.zero;
    for (final dir in input.split(',').map((d) => hexDirs[d]!)) {
      pos += dir;
    }
    return pos.manhattanDistanceTo(Vec3.zero) ~/ 2;
  }

  @override
  dynamic part2(String input) {
    Vec3 pos = Vec3.zero;
    int farthest = 0;
    for (final dir in input.split(',').map((d) => hexDirs[d]!)) {
      pos += dir;
      farthest = max(farthest, pos.manhattanDistanceTo(Vec3.zero) ~/ 2);
    }
    return farthest;
  }

  // Using Cube notation for a hex grid from:
  //
  // https://www.redblobgames.com/grids/hexagons/#coordinates-cube
  //
  // We can easily add up the positsions and use half the Manhatten distance
  // for distance we have travelled.
  final hexDirs = {
    'n': Vec3(1, 0, -1),
    'ne': Vec3(0, 1, -1),
    'se': Vec3(-1, 1, 0),
    's': Vec3(-1, 0, 1),
    'sw': Vec3(0, -1, 1),
    'nw': Vec3(1, -1, 0),
  };
}
