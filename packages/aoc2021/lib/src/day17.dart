// https://adventofcode.com/2021/day/17

import 'dart:math';

import 'package:aoc/aoc.dart';
import 'package:aoc/util/vec2.dart';

main() => Day17().solve();

class Day17 extends AdventDay {
  Day17() : super(2021, 17, name: 'Trick Shot');

  @override
  dynamic part1(String input) {
    final target = parseRegion(input);

    int totalMaxY = 0;
    for (int vx = 0; vx <= target.max.x; vx++) {
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
  dynamic part2(String input) {
    final target = parseRegion(input);

    int numHit = 0;
    for (int vx = 0; vx <= target.max.x; vx++) {
      // TODO: calculate a better upper bound for vy.
      for (int vy = target.min.yInt; vy < 1000; vy++) {
        if (highestHittingTarget(vx, vy, target) != null) {
          numHit++;
        }
      }
    }
    return numHit;
  }

  Region parseRegion(String input) {
    final match = RegExp(r'x=(.*)\.\.(.*), y=(.*)\.\.(.*)').firstMatch(input)!;
    return Region(
      Vec2(double.parse(match.group(1)!), double.parse(match.group(3)!)),
      Vec2(double.parse(match.group(2)!), double.parse(match.group(4)!)),
    );
  }

  int? highestHittingTarget(int vx, int vy, Region target) {
    int maxY = 0;
    int px = 0;
    int py = 0;
    while (px <= target.max.x && py >= target.min.y) {
      px += vx;
      py += vy;
      maxY = max(maxY, py);
      if (target.contains(px, py)) {
        return maxY;
      }
      vx -= vx.sign;
      vy -= 1;
    }
    return null;
  }
}

class Region {
  Region(this.min, this.max);

  final Vec2 min;
  final Vec2 max;

  bool contains(int px, int py) =>
      min.x <= px && px <= max.x && min.y <= py && py <= max.y;
}
