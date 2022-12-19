// https://adventofcode.com/2022/day/18

import 'dart:math';

import 'package:collection/collection.dart';

import '../../day.dart';
import '../util/vec3.dart';

class Day18 extends AdventDay {
  Day18() : super(2022, 18, solution1: 4302, solution2: 2492);

  @override
  dynamic part1() {
    final cubes = inputCubes().toSet();
    return cubes
      .map((c) => _dirs
        .whereNot((d) => cubes.contains(c + d))
        .length)
      .sum;
  }

  @override
  dynamic part2() {
    final cubes = inputCubes().toSet();
    Vec3 minV = Vec3.zero;
    Vec3 maxV = Vec3.zero;
    for (final cube in cubes) {
      minV = Vec3(min(minV.x, cube.x), min(minV.y, cube.y), min(minV.z, cube.z));
      maxV = Vec3(max(maxV.x, cube.x), max(maxV.y, cube.y), max(maxV.z, cube.z));
    }

    bool inside(Vec3 p) =>
        minV.x <= p.x && p.x <= maxV.x &&
        minV.y <= p.y && p.y <= maxV.y &&
        minV.z <= p.z && p.z <= maxV.z;

    bool expandConnected(Set<Vec3> group) {
      final seeds = Set.from(group.map((p) => _dirs.map((d) => p + d)).flattened);
      bool groupExposed = false;
      while (seeds.isNotEmpty) {
        final seed = seeds.first;
        seeds.remove(seed);
        if (group.contains(seed) || cubes.contains(seed)) {
          continue;
        }
        if (!inside(seed)) {
          groupExposed = true;
          continue;
        }
        group.add(seed);
        seeds.addAll(_dirs
          .map((d) => seed + d)
          .where((v) => !group.contains(v) && !cubes.contains(v)));
      }
      return groupExposed;
    }

    Set<Vec3> trapped = <Vec3>{};
    Set<Vec3> exposed = <Vec3>{};
    for (int z = minV.zInt; z <= maxV.zInt; z++) {
      for (int y = minV.yInt; y <= maxV.yInt; y++) {
        for (int x = minV.xInt; x <= maxV.xInt; x++) {
          final pos = Vec3.int(x, y, z);
          if (!cubes.contains(pos) && !trapped.contains(pos) && !exposed.contains(pos)) {
            Set<Vec3> group = { pos };
            if (expandConnected(group)) {
              exposed.addAll(group);
            } else {
              trapped.addAll(group);
            }
          }
        }
      }
    }

    // Fill in all trapped locations
    cubes.addAll(trapped);

    return cubes
      .map((c) => _dirs
        .whereNot((d) => cubes.contains(c + d))
        .length)
      .sum;
  }

  List<Vec3> inputCubes() {
    return inputDataLines()
      .map((s) => s.split(',').map(int.parse).toList())
      .map((v) => Vec3.int(v[0], v[1], v[2]))
      .toList();
  }

  static const _dirs = <Vec3>[
    Vec3(0, 1, 0), // Up
    Vec3(0, -1, 0), // Down
    Vec3(-1, 0, 0), // Left
    Vec3(1, 0, 0), // Right
    Vec3(0, 0, 1), // Forward
    Vec3(0, 0, -1), // Backward
  ];

}
