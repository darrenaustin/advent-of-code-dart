// https://adventofcode.com/2023/day/18

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:aoc/util/vec.dart';

main() => Day18().solve();

class Day18 extends AdventDay {
  Day18() : super(2023, 18, name: '');

  @override
  dynamic part1(String input) {
    var current = Vec2.zero;
    final points = <Vec2>[current];
    for (final l in input.lines) {
      final parts = l.split(' ');
      final dir = dirVecs[parts[0]]!;
      final count = int.parse(parts[1]);
      current += dir * count;
      points.add(current);
    }
    return shoelaceArea(points);
  }

  @override
  dynamic part2(String input) {
    var current = Vec2.zero;
    final points = <Vec2>[current];
    for (final l in input.lines) {
      final match = RegExp(r'.*\(#(.*)\)').firstMatch(l)!;
      final hex = match.group(1)!;
      final count = int.parse(hex.substring(0, 5), radix: 16);
      final dir = hexDirVecs[hex.substring(5)]!;
      current += dir * count;
      points.add(current);
    }
    return shoelaceArea(points);
  }

  int shoelaceArea(List<Vec2> points) {
    double perimeter = 0;
    double area = 0;
    for (int i = 0; i < points.length - 1; i++) {
      perimeter += points[i].manhattanDistanceTo(points[i + 1]);
      area += points[i].x * points[i + 1].y - points[i + 1].x * points[i].y;
    }
    return (perimeter + area) ~/ 2 + 1;
  }

  static final dirVecs = {
    'R': Vec2.right,
    'D': Vec2.down,
    'L': Vec2.left,
    'U': Vec2.up,
  };

  static final hexDirVecs = {
    '0': Vec2.right,
    '1': Vec2.down,
    '2': Vec2.left,
    '3': Vec2.up,
  };
}
