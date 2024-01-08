// https://adventofcode.com/2023/day/24

import 'package:aoc/aoc.dart';
import 'package:aoc/util/combinatorics.dart';
import 'package:aoc/util/linear.dart';
import 'package:aoc/util/math.dart';
import 'package:aoc/util/range.dart';
import 'package:aoc/util/string.dart';

main() => Day24().solve();

class Day24 extends AdventDay {
  Day24() : super(2023, 24, name: 'Never Tell Me The Odds');

  @override
  dynamic part1(String input,
      [range = const Range(200000000000000, 400000000000001)]) {
    // I had already solved this with a similar method, but it
    // involved a Stone data structure and a projection intersection
    // method. Seeing Axel's solution in Rust inspired me to this more
    // straightforward solution:
    //
    // https://github.com/AxlLind/AdventOfCode2023/blob/main/src/bin/24.rs

    final stones = input.lines.map((l) => l.numbers());
    return combinations(stones, 2).where((pair) {
      final [x1, y1, _, vx1, vy1, _] = pair.first;
      final [x2, y2, _, vx2, vy2, _] = pair.last;

      // Compute slopes.
      final m1 = vy1 / vx1;
      final m2 = vy2 / vx2;
      final denom = m2 - m1;
      if (denom.effectivelyZero) {
        // Slopes are the same, thus parallel and no intersection.
        return false;
      }

      // Compute intesection point.
      final x = (-m1 * x1 + m2 * x2 - y2 + y1) / denom;
      final y = (m1 * m2 * (x2 - x1) + m2 * y1 - m1 * y2) / denom;

      if (vx1.sign != (x - x1).sign || vx2.sign != (x - x2).sign) {
        // One of the velocities is going in the opposite direction
        // from the starting point to the intersection, so they are
        // intersecting in the past.
        return false;
      }

      // Ensure the coords are in the right range.
      return [x, y].every((n) => range.contains(n));
    }).length;
  }

  @override
  dynamic part2(String input) {
    // Spent a bunch of time looking at various solutions, including
    // z3 or some other symbolic solver. After looking at solutions
    // people posted to the subreddit, I liked the Gaussian Elimination
    // method for solving a system of linear equations.
    //
    // My solution is based on Trevor's:
    //
    // https://github.com/tmbarker/advent-of-code/blob/main/Solutions/Y2023/D24/Solution.cs
    //

    // Let:
    //
    //    rock_pos(t) = <X, Y, Z> + t * <VX, VY, VZ>
    //    hail_pos(t) = <x, y, z> + t * <vx, vy, vz>
    //
    // Where rock_pos is the position of the rock at given time t, and
    // hail_pos is the position of any hailstone at time t.
    //
    // Therefore the intersection of the rock with a hailstone can be
    // described by:
    //
    //    X + t * VX = x + t * x  or  t = (X - x) / (vx - VX)
    //    Y + t * VY = y + t * y  or  t = (Y - y) / (vy - VY)
    //    Z + t * VZ = z + t * z  or  t = (Z - z) / (vz - VZ)
    //
    // Given t is the same for all of these, we can equate the X and Y
    // equations above to arrive at:
    //
    //  XY:
    //    (X - x) / (vx - VX) = (Y - y) / (vy - VY)
    //    (X - x) * (vy - VY) = (Y - y) * (vx - VX)
    //    X * vy - X * VY - x * vy + x * VY = Y * vx - Y * VX - y * vx + y * VX
    //    Y * VX - X * VY = -X * vy - x * vy - x * VY + Y * vx - y * vx + y * VX
    //
    // Given that the terms on the left are all defined completely by the rock
    // parameters, it will be the same for all hail stones. Therefore if we
    // have two hailstones, we can equate the equivalent of the right hand
    // side for both:
    //
    //  (vy2-vy1) X + (vx1-vx2) Y + (y1-y2) VX + (x2-x1) VY = x2 vy2 - y2 vx2 - x1 vy1 + y1 vx1
    //
    // And similarly for XZ and YZ we get:
    //
    //  (vz2-vz1) X + (vx1-vx2) Z + (z1-z2) VX + (x2-x1) VZ = x2 vz2 - z2 vx2 - x1 vz1 + z1 vx1
    //  (vz1-vz2) Y + (vy2-vy1) Z + (z2-z1) VY + (y1-y2) VZ = -y2 vz2 + z2 vy2 + y1 vz1 - z1 vy1
    //
    // Appying these three equations to three different hailstones, we can
    // construct a system of six equations with six unknowns, which is solveable
    // with linear algebra.

    List<num> coefficientsXY(Stone s1, Stone s2) => [
          // (vy2-vy1) X + (vx1-vx2) Y + (y1-y2) VX + (x2-x1) VY = x2 vy2 - y2 vx2 - x1 vy1 + y1 vx1
          s2.vy - s1.vy,
          s1.vx - s2.vx,
          0,
          s1.y - s2.y,
          s2.x - s1.x,
          0,
          s2.x * s2.vy - s2.y * s2.vx - s1.x * s1.vy + s1.y * s1.vx,
        ];

    List<num> coefficientsXZ(Stone s1, Stone s2) => [
          //  (vz2-vz1) X + (vx1-vx2) Z + (z1-z2) VX + (x2-x1) VZ = x2 vz2 - z2 vx2 - x1 vz1 + z1 vx1
          s2.vz - s1.vz,
          0,
          s1.vx - s2.vx,
          s1.z - s2.z,
          0,
          s2.x - s1.x,
          s2.x * s2.vz - s2.z * s2.vx - s1.x * s1.vz + s1.z * s1.vx,
        ];

    List<num> coefficientsYZ(Stone s1, Stone s2) => [
          //  (vz1-vz2) Y + (vy2-vy1) Z + (z2-z1) VY + (y1-y2) VZ = -y2 vz2 + z2 vy2 + y1 vz1 - z1 vy1
          0,
          s1.vz - s2.vz,
          s2.vy - s1.vy,
          0,
          s2.z - s1.z,
          s1.y - s2.y,
          -s2.y * s2.vz + s2.z * s2.vy + s1.y * s1.vz - s1.z * s1.vy,
        ];

    final stones = input.lines.map(Stone.parse).toList();
    final coefficients = [
      coefficientsXY(stones[0], stones[1]),
      coefficientsXY(stones[0], stones[2]),
      coefficientsXZ(stones[0], stones[1]),
      coefficientsXZ(stones[0], stones[2]),
      coefficientsYZ(stones[0], stones[1]),
      coefficientsYZ(stones[0], stones[2]),
    ];
    final solution = solveLinearSystem(coefficients).map((n) => n.round());
    final [x, y, z, _, _, _] = solution.toList();
    return x + y + z;
  }
}

class Stone {
  Stone(this.x, this.y, this.z, this.vx, this.vy, this.vz);

  factory Stone.parse(String input) {
    final [x, y, z, vx, vy, vz] = input.numbers();
    return Stone(x, y, z, vx, vy, vz);
  }

  final num x, y, z, vx, vy, vz;
}
