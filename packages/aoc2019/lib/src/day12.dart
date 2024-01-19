// https://adventofcode.com/2019/day/12

import 'package:aoc/aoc.dart';
import 'package:aoc/util/math.dart';
import 'package:aoc/util/range.dart';
import 'package:aoc/util/string.dart';
import 'package:aoc/util/vec3.dart';
import 'package:collection/collection.dart';

main() => Day12().solve();

class Day12 extends AdventDay {
  Day12() : super(2019, 12, name: 'The N-Body Problem');

  @override
  dynamic part1(String input, [int steps = 1000]) {
    final moons = parseMoons(input);
    for (final _ in range(steps)) {
      simulate(moons);
    }
    return moons.map(energy).sum;
  }

  @override
  dynamic part2(String input) {
    final moons = parseMoons(input);
    final xCycle = CycleDetector();
    final yCycle = CycleDetector();
    final zCycle = CycleDetector();

    while (!xCycle.detected || !yCycle.detected || !zCycle.detected) {
      xCycle.update(
          moons.map((m) => m.position.x), moons.map((m) => m.velocity.x));
      yCycle.update(
          moons.map((m) => m.position.y), moons.map((m) => m.velocity.y));
      zCycle.update(
          moons.map((m) => m.position.z), moons.map((m) => m.velocity.z));
      simulate(moons);
    }
    return [xCycle.cycle!, yCycle.cycle!, zCycle.cycle!].reduce(lcm);
  }

  List<Moon> parseMoons(String input) {
    return input.lines.map((l) {
      final match = RegExp(r'<x=(-?\d+), y=(-?\d+), z=(-?\d+)>').firstMatch(l)!;
      return Moon(
        Vec3(int.parse(match.group(1)!), int.parse(match.group(2)!),
            int.parse(match.group(3)!)),
        Vec3(0, 0, 0),
      );
    }).toList();
  }

  void simulate(List<Moon> moons) {
    applyGravity(moons[0], moons[1]);
    applyGravity(moons[0], moons[2]);
    applyGravity(moons[0], moons[3]);
    applyGravity(moons[1], moons[2]);
    applyGravity(moons[1], moons[3]);
    applyGravity(moons[2], moons[3]);

    moons.forEach(applyVelocity);
  }

  void applyGravity(Moon m1, Moon m2) {
    final positionDelta = m2.position - m1.position;
    final m1VelocityDelta =
        Vec3(positionDelta.x.sign, positionDelta.y.sign, positionDelta.z.sign);
    m1.velocity += m1VelocityDelta;
    m2.velocity -= m1VelocityDelta;
  }

  void applyVelocity(Moon m) => m.position += m.velocity;

  num energy(Moon m) {
    final potential =
        m.position.x.abs() + m.position.y.abs() + m.position.z.abs();
    final kinetic =
        m.velocity.x.abs() + m.velocity.y.abs() + m.velocity.z.abs();
    return potential * kinetic;
  }
}

class Moon {
  Moon(this.position, this.velocity);
  Vec3 position;
  Vec3 velocity;
}

class CycleDetector {
  late final List<num> _positions;
  late final List<num> _velocities;

  int? cycle;
  bool get detected => cycle != null;

  final _iterEq = IterableEquality().equals;

  int _count = 0;

  void update(Iterable<num> positions, Iterable<num> velocities) {
    if (!detected) {
      if (_count == 0) {
        _positions = List.from(positions);
        _velocities = List.from(velocities);
        _count = 1;
      } else if (_iterEq(_positions, positions) &&
          _iterEq(_velocities, velocities)) {
        cycle = _count;
      } else {
        _count++;
      }
    }
  }
}
