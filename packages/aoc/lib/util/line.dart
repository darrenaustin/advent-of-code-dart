import 'dart:math';

import 'math.dart';
import 'range.dart';
import 'vec.dart';

class Line {
  Line(this.from, this.to);

  final Vec from;
  final Vec to;

  num get slope => (to.y - from.y) / (to.x - from.x);
  num get intercept => from.y - slope * from.x;
  bool get isOrthogonal => from.x == to.x || from.y == to.y;

  Vec? intersection(Line other) {
    final Vec dir = to - from;
    final Vec otherDir = other.to - other.from;
    final num dirCross = dir.crossProduct(otherDir);
    if (dirCross != 0) {
      final num t = (other.from - from).crossProduct(otherDir) / dirCross;
      final num u = (other.from - from).crossProduct(dir) / dirCross;
      if (0 <= t && t <= 1 && 0 <= u && u <= 1) {
        return from + dir * t;
      }
    }
    return null;
  }

  num? distanceAlong(Vec p) {
    final Vec dir = to - from;
    final Vec dirP = p - from;
    final num cross = dir.crossProduct(dirP);
    if (cross.abs() <= epsilon) {
      final num dot = dir.dotProduct(dirP);
      if (dot > 0) {
        final num squaredDist = from.squaredDistanceTo(to);
        if (dot < squaredDist) {
          return dot / sqrt(squaredDist);
        }
      }
    }
    return null;
  }

  Iterable<Vec> discretePointsAlong() sync* {
    final num m = slope;
    final num b = intercept;
    if (m.isInfinite) {
      // vertical line
      for (final int y in rangeinc(from.y.truncate(), to.y.truncate())) {
        yield Vec(from.x, y.toDouble());
      }
    } else {
      for (final int x in rangeinc(from.x.truncate(), to.x.truncate())) {
        final num y = m * x + b;
        if ((y - y.truncateToDouble()).abs() < epsilon) {
          yield Vec(x.toDouble(), y.truncateToDouble());
        }
      }
    }
  }

  num get manhattanDistance => from.manhattanDistanceTo(to);

  @override
  String toString() => 'Line2($from, $to)';
}
