// https://adventofcode.com/2021/day/17

import 'dart:math';

import 'package:aoc/aoc.dart';

class Day17 extends AdventDay {
  Day17() : super(2021, 17, solution1: 12561, solution2: 3785);

  @override
  dynamic part1() {
    final target = inputRegion();

    int totalMaxY = 0;
    for (int vx = 0; vx <= target.xMax; vx++) {
      // TODO: calculate a better upper bound for vy.
      for (int vy = 0; vy < 1000; vy++) {
        final yMax = highestHittingTarget(vx, vy, target);
        if (yMax != null) {
          totalMaxY = max(yMax, totalMaxY);
        }
      }
    }
    return totalMaxY;
  }

  @override
  dynamic part2() {
    final target = inputRegion();

    int numHit = 0;
    for (int vx = 0; vx <= target.xMax; vx++) {
      // TODO: calculate a better upper bound for vy.
      for (int vy = target.yMin; vy < 1000; vy++) {
        if (highestHittingTarget(vx, vy, target) != null) {
          numHit++;
        }
      }
    }
    return numHit;
  }

  Region inputRegion() {
    final regionMatch = RegExp(r'target area: x=(.*)\.\.(.*), y=(.*)\.\.(.*)').firstMatch(inputData())!;
    return Region(
       int.parse(regionMatch.group(1)!),
       int.parse(regionMatch.group(2)!),
       int.parse(regionMatch.group(3)!),
       int.parse(regionMatch.group(4)!),
    );
  }

  int? highestHittingTarget(int vx, int vy, Region target) {
    int maxY = 0;
    int x = 0;
    int y = 0;
    while (x <= target.xMax && y >= target.yMin) {
      x += vx;
      y += vy;
      maxY = max(maxY, y);
      if (target.contains(x, y)) {
        return maxY;
      }
      if (vx != 0) {
        vx = vx + ((vx > 0) ? -1 : 1);
      }
      vy--;
    }
    return null;
  }
}

class Region {
  Region(this.xMin, this.xMax, this.yMin, this.yMax);

  final int xMin;
  final int xMax;
  final int yMin;
  final int yMax;

  bool contains(int x, int y) => xMin <= x && x <= xMax && yMin <= y && y <= yMax;

  @override
  String toString() {
    return 'x=$xMin..$xMax, y=$yMin..$yMax';
  }
}
