// https://adventofcode.com/2019/day/12

import 'package:aoc/aoc.dart';
import 'package:aoc/util/math.dart';
import 'package:aoc/util/vec3.dart';
import 'package:collection/collection.dart';

class Day12 extends AdventDay {
  Day12() : super(2019, 12, solution1: 7202, solution2: 537881600740876);

  @override
  dynamic part1() {
    final moons = inputMoons();
    for (var step = 1; step <= 1000; step++) {
      simulate(moons);
    }
    return moons.map(energy).sum;
  }

  @override
  dynamic part2() {
    final moons = inputMoons();
    final xCycle = CycleDetector();
    final yCycle = CycleDetector();
    final zCycle = CycleDetector();

    while (!xCycle.detected || !yCycle.detected || !zCycle.detected) {
      xCycle.update(
          moons[0].position.x, moons[1].position.x, moons[2].position.x, moons[3].position.x,
          moons[0].velocity.x, moons[1].velocity.x, moons[2].velocity.x, moons[3].velocity.x
      );
      yCycle.update(
          moons[0].position.y, moons[1].position.y, moons[2].position.y, moons[3].position.y,
          moons[0].velocity.y, moons[1].velocity.y, moons[2].velocity.y, moons[3].velocity.y
      );
      zCycle.update(
          moons[0].position.z, moons[1].position.z, moons[2].position.z, moons[3].position.z,
          moons[0].velocity.z, moons[1].velocity.z, moons[2].velocity.z, moons[3].velocity.z
      );
      simulate(moons);
    }
    return [xCycle.cycle!, yCycle.cycle!, zCycle.cycle!].reduce(lcm);
  }

  List<Moon> inputMoons() {
    return inputDataLines().map((l) {
      final parse = RegExp(r'<x=(-?\d+), y=(-?\d+), z=(-?\d+)>').firstMatch(l)!;
      return Moon(
        Vec3.int(int.parse(parse.group(1)!), int.parse(parse.group(2)!), int.parse(parse.group(3)!)),
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
    final m1VelocityDelta = Vec3(positionDelta.x.sign, positionDelta.y.sign, positionDelta.z.sign);
    m1.velocity += m1VelocityDelta;
    m2.velocity += m1VelocityDelta * -1;
  }

  void applyVelocity(Moon m) => m.position += m.velocity;

  num energy(Moon m) {
    final potential = m.position.x.abs() + m.position.y.abs() + m.position.z.abs();
    final kinetic = m.velocity.x.abs() + m.velocity.y.abs() + m.velocity.z.abs();
    return potential * kinetic;
  }
}

class Moon {
  Moon(this.position, this.velocity);

  Vec3 position;
  Vec3 velocity;

  @override
  String toString() {
    return 'Moon pos=$position, vel=$velocity';
  }
}

class CycleDetector {

  late final double _p1;
  late final double _p2;
  late final double _p3;
  late final double _p4;
  late final double _v1;
  late final double _v2;
  late final double _v3;
  late final double _v4;

  int? cycle;
  bool get detected => cycle != null;

  int _count = 0;

  void update(
    double p1, double p2, double p3, double p4,
    double v1, double v2, double v3, double v4
  ) {
    if (!detected) {
      if (_count == 0) {
        _p1 = p1; _p2 = p2; _p3 = p3; _p4 = p4; _v1 = v1; _v2 = v2; _v3 = v3; _v4 = v4;
        _count = 1;
      } else if (_p1 == p1 && _p2 == p2 && _p3 == p3 && _p4 == p4 &&
          _v1 == v1 && _v2 == v2 && _v3 == v3 && _v4 == v4) {
        cycle = _count;
      } else {
        _count++;
      }
    }
  }
}
