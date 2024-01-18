// https://adventofcode.com/2023/day/18

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:aoc/util/vec.dart';

main() => Day18().solve();

class Day18 extends AdventDay {
  Day18() : super(2023, 18, name: '');

  @override
  dynamic part1(String input) {
    var current = Vec.zero;
    final points = <Vec>[current];
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
    var current = Vec.zero;
    final points = <Vec>[current];
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

  int shoelaceArea(List<Vec> points) {
    double perimeter = 0;
    double area = 0;
    for (int i = 0; i < points.length - 1; i++) {
      perimeter += points[i].manhattanDistanceTo(points[i + 1]);
      area += points[i].x * points[i + 1].y - points[i + 1].x * points[i].y;
    }
    return (perimeter + area) ~/ 2 + 1;
  }

  static final dirVecs = {
    'R': Vec.right,
    'D': Vec.down,
    'L': Vec.left,
    'U': Vec.up,
  };

  static final hexDirVecs = {
    '0': Vec.right,
    '1': Vec.down,
    '2': Vec.left,
    '3': Vec.up,
  };
}
