import 'dart:math';

import 'math.dart';
import 'range.dart';

class Vec {
  const Vec(this.x, this.y);

  Vec.int(int x, int y)
      : x = x.toDouble(),
        y = y.toDouble();

  final double x;
  final double y;

  int get xInt => x.toInt();
  int get yInt => y.toInt();

  static const Vec zero = Vec(0, 0);
  static const Vec up = Vec(0, -1);
  static const Vec upRight = Vec(1, -1);
  static const Vec right = Vec(1, 0);
  static const Vec downRight = Vec(1, 1);
  static const Vec down = Vec(0, 1);
  static const Vec downLeft = Vec(-1, 1);
  static const Vec left = Vec(-1, 0);
  static const Vec upLeft = Vec(-1, -1);
  static const Vec north = up;
  static const Vec west = left;
  static const Vec east = right;
  static const Vec south = down;

  static const List<Vec> cardinalDirs = <Vec>[
    Vec.upLeft,
    Vec.up,
    Vec.upRight,
    Vec.left,
    Vec.zero,
    Vec.right,
    Vec.downLeft,
    Vec.down,
    Vec.downRight,
  ];

  static const List<Vec> aroundDirs = <Vec>[
    Vec.upLeft,
    Vec.up,
    Vec.upRight,
    Vec.left,
    Vec.right,
    Vec.downLeft,
    Vec.down,
    Vec.downRight,
  ];

  static const List<Vec> orthogonalDirs = [
    Vec.up,
    Vec.down,
    Vec.left,
    Vec.right,
  ];

  double get magnitude => sqrt(x * x + y * y);

  double get squaredMagnitude => x * x + y * y;

  double get direction => atan2(y, x);

  Vec translate(num dx, num dy) => Vec(x + dx, y + dy);

  Vec scale(num scaleX, num scaleY) => Vec(x * scaleX, y * scaleY);

  double distanceTo(Vec other) => (this - other).magnitude;

  double squaredDistanceTo(Vec other) => (this - other).squaredMagnitude;

  double manhattanDistanceTo(Vec other) =>
      (x - other.x).abs() + (y - other.y).abs();

  double crossProduct(Vec other) => x * other.y - y * other.x;

  double dotProduct(Vec other) => x * other.x + y * other.y;

  double angle(Vec other) => (other - this).direction;

  Vec operator +(Vec other) => Vec(x + other.x, y + other.y);

  Vec operator -() => Vec(-x, -y);

  Vec operator -(Vec other) => Vec(x - other.x, y - other.y);

  Vec operator *(num factor) => Vec(x * factor, y * factor);

  static Iterable<Vec> range(Vec min, Vec max) sync* {
    for (int y = min.yInt; y < max.yInt; y++) {
      for (int x = min.xInt; x < max.xInt; x++) {
        yield Vec.int(x, y);
      }
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(other, this) ||
      (other is Vec &&
          other.runtimeType == runtimeType &&
          other.x == x &&
          other.y == y);

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  @override
  String toString() => 'Vec2($x, $y)';
}

class LineSegment2 {
  LineSegment2(this.from, this.to);

  final Vec from;
  final Vec to;

  double get slope => (to.y - from.y) / (to.x - from.x);
  double get intercept => from.y - slope * from.x;
  bool get isOrthogonal => from.x == to.x || from.y == to.y;

  Vec? intersection(LineSegment2 other) {
    final Vec dir = to - from;
    final Vec otherDir = other.to - other.from;
    final double dirCross = dir.crossProduct(otherDir);
    if (dirCross != 0) {
      final double t = (other.from - from).crossProduct(otherDir) / dirCross;
      final double u = (other.from - from).crossProduct(dir) / dirCross;
      if (0 <= t && t <= 1 && 0 <= u && u <= 1) {
        return from + dir * t;
      }
    }
    return null;
  }

  double? distanceAlong(Vec p) {
    final Vec dir = to - from;
    final Vec dirP = p - from;
    final double cross = dir.crossProduct(dirP);
    if (cross.abs() <= epsilon) {
      final double dot = dir.dotProduct(dirP);
      if (dot > 0) {
        final double squaredDist = from.squaredDistanceTo(to);
        if (dot < squaredDist) {
          return dot / sqrt(squaredDist);
        }
      }
    }
    return null;
  }

  Iterable<Vec> discretePointsAlong() sync* {
    final double m = slope;
    final double b = intercept;
    if (m.isInfinite) {
      // vertical line
      for (final int y in rangeinc(from.y.truncate(), to.y.truncate())) {
        yield Vec(from.x, y.toDouble());
      }
    } else {
      for (final int x in rangeinc(from.x.truncate(), to.x.truncate())) {
        final double y = m * x + b;
        if ((y - y.truncateToDouble()).abs() < epsilon) {
          yield Vec(x.toDouble(), y.truncateToDouble());
        }
      }
    }
  }

  double get manhattanDistance => from.manhattanDistanceTo(to);

  @override
  String toString() => 'Line2($from, $to)';
}
