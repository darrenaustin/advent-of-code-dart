// https://adventofcode.com/2020/day/17

import 'dart:math';

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:aoc/util/vec.dart';

main() => Day17().solve();

class Day17 extends AdventDay {
  Day17() : super(2020, 17, name: 'Conway Cubes');

  @override
  dynamic part1(String input) =>
      cycleWorld(parseWorld(input), 6, _adjacentOffets3d)
          .whereCells(isActive)
          .length;

  @override
  dynamic part2(String input) =>
      cycleWorld(parseWorld(input), 6, _adjacentOffets4d)
          .whereCells(isActive)
          .length;

  World<String> parseWorld(String input) {
    final rows = input.lines.map((e) => e.chars).toList();
    final width = rows[0].length;
    final height = rows.length;
    final world = World<String>(defaultValue: '.');
    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        world.setCell(Vec4.int(x, y), rows[y][x]);
      }
    }
    return world;
  }

  bool isActive(String cell) => cell == '#';

  World<String> cycleWorld(
      World<String> world, int cycles, Iterable<Vec4> adjacentOffsets) {
    for (var cycle = 0; cycle < cycles; cycle++) {
      final nextWorld = World<String>(defaultValue: world.defaultValue);

      final minPoint = world.minPoint - Vec4(1, 1, 1, 1);
      final maxPoint = world.maxPoint + Vec4(1, 1, 1, 1);
      for (double w = minPoint.w; w <= maxPoint.w; w++) {
        for (double z = minPoint.z; z <= maxPoint.z; z++) {
          for (double y = minPoint.y; y <= maxPoint.y; y++) {
            for (double x = minPoint.x; x <= maxPoint.x; x++) {
              final p = Vec4(x, y, z, w);
              final numActiveNeighbors = adjacentOffsets
                  .where((o) => isActive(world.cell(p + o)))
                  .length;
              final cell = world.cell(p);
              if (isActive(cell)) {
                if (numActiveNeighbors == 2 || numActiveNeighbors == 3) {
                  nextWorld.setCell(p, '#');
                }
              } else {
                if (numActiveNeighbors == 3) {
                  nextWorld.setCell(p, '#');
                }
              }
            }
          }
        }
      }
      world = nextWorld;
    }
    return world;
  }

  static final _adjacentOffets3d = _offsets(Vec4(-1, -1, -1), Vec4(1, 1, 1));
  static final _adjacentOffets4d =
      _offsets(Vec4(-1, -1, -1, -1), Vec4(1, 1, 1, 1));

  static Iterable<Vec4> _offsets(Vec4 min, Vec4 max) {
    final offsets = <Vec4>[];
    for (double w = min.w; w <= max.w; w++) {
      for (double z = min.z; z <= max.z; z++) {
        for (double y = min.y; y <= max.y; y++) {
          for (double x = min.x; x <= max.x; x++) {
            if (x != 0 || y != 0 || z != 0 || w != 0) {
              offsets.add(Vec4(x, y, z, w));
            }
          }
        }
      }
    }
    return offsets;
  }
}

class World<T> {
  World({required this.defaultValue})
      : _cells = {},
        _min = Vec4.zero,
        _max = Vec4.zero;

  final T defaultValue;

  final Map<int, Map<int, Map<int, Map<int, T>>>> _cells;

  Vec4 get minPoint => _min;
  Vec4 _min;
  Vec4 get maxPoint => _max;
  Vec4 _max;

  T cell(Vec4 p) {
    final w = _cells[p.w];
    if (w != null) {
      final z = w[p.z];
      if (z != null) {
        final y = z[p.y];
        if (y != null) {
          final x = y[p.x];
          return x ?? defaultValue;
        }
      }
    }
    return defaultValue;
  }

  void setCell(Vec4 p, T value) {
    final w = _cells[p.w] ?? {};
    final z = w[p.z] ?? {};
    final y = z[p.y] ?? {};
    y[p.xInt] = value;
    z[p.yInt] = y;
    w[p.zInt] = z;
    _cells[p.wInt] = w;
    _min = Vec4(
        min(_min.x, p.x), min(_min.y, p.y), min(_min.z, p.z), min(_min.w, p.w));
    _max = Vec4(
        max(_max.x, p.x), max(_max.y, p.y), max(_max.z, p.z), max(_max.w, p.w));
  }

  Iterable<T> whereCells(bool Function(T) test,
      [Vec4? minP, Vec4? maxP]) sync* {
    final min = minP ?? minPoint;
    final max = maxP ?? maxPoint;
    for (double w = min.w; w <= max.w; w++) {
      for (double z = min.z; z <= max.z; z++) {
        for (double y = min.y; y <= max.y; y++) {
          for (double x = min.x; x <= max.x; x++) {
            final c = cell(Vec4(x, y, z, w));
            if (test(c)) {
              yield c;
            }
          }
        }
      }
    }
  }
}
