// https://adventofcode.com/2018/day/3

import 'dart:math';

import 'package:aoc/aoc.dart';
import 'package:aoc/util/grid2.dart';
import 'package:aoc/util/string.dart';
import 'package:aoc/util/vec.dart';

main() => Day03().solve();

class Day03 extends AdventDay {
  Day03() : super(2018, 3, name: 'No Matter How You Slice It');

  @override
  dynamic part1(String input) {
    final fabric = Grid<int>(1000, 1000, 0);
    for (final claim in input.lines.map(Claim.parse)) {
      final rect = claim.rect;
      for (int x = 0; x < rect.width; x++) {
        for (int y = 0; y < rect.height; y++) {
          final pos = Vec2.int(rect.x + x, rect.y + y);
          fabric.setCell(pos, fabric.cell(pos) + 1);
        }
      }
    }
    return fabric.cellsWhere((c) => c > 1).length;
  }

  @override
  dynamic part2(String input) {
    final claims = input.lines.map(Claim.parse).toList();
    final intersecting = <int>{};
    for (int i = 0; i < claims.length - 1; i++) {
      for (int j = i + 1; j < claims.length; j++) {
        if (claims[i].rect.intersects(claims[j].rect)) {
          intersecting.add(claims[i].id);
          intersecting.add(claims[j].id);
        }
      }
    }
    return claims.firstWhere((c) => !intersecting.contains(c.id)).id;
  }
}

class Claim {
  Claim(this.id, this.rect);

  static Claim parse(String s) {
    final match =
        RegExp(r'#([\d]+) @ ([\d]+),([\d]+): ([\d]+)x([\d]+)').firstMatch(s);
    if (match == null) {
      throw Exception('unable to parse claim from $s');
    }
    return Claim(
        int.parse(match.group(1)!),
        Rect(int.parse(match.group(2)!), int.parse(match.group(3)!),
            int.parse(match.group(4)!), int.parse(match.group(5)!)));
  }

  final int id;
  final Rect rect;
}

class Rect {
  const Rect(this.x, this.y, this.width, this.height);

  final int x;
  final int y;
  final int width;
  final int height;

  int get right => x + width;
  int get bottom => y + height;

  bool intersects(Rect other) =>
      max(x, other.x) < min(right, other.right) &&
      max(y, other.y) < min(bottom, other.bottom);
}
