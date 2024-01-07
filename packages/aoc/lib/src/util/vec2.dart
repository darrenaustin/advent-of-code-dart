import 'dart:math';

import 'math.dart';
import 'range.dart';

class Vec2 {
  const Vec2(this.x, this.y);

  Vec2.int(int x, int y)
      : x = x.toDouble(),
        y = y.toDouble();

  final double x;
  final double y;

  int get xInt => x.toInt();
  int get yInt => y.toInt();

  static const Vec2 zero = Vec2(0, 0);
  static const Vec2 up = Vec2(0, -1);
  static const Vec2 upRight = Vec2(1, -1);
  static const Vec2 right = Vec2(1, 0);
  static const Vec2 downRight = Vec2(1, 1);
  static const Vec2 down = Vec2(0, 1);
  static const Vec2 downLeft = Vec2(-1, 1);
  static const Vec2 left = Vec2(-1, 0);
  static const Vec2 upLeft = Vec2(-1, -1);
  static const Vec2 north = up;
  static const Vec2 west = left;
  static const Vec2 east = right;
  static const Vec2 south = down;

  static const List<Vec2> cardinalDirs = <Vec2>[
    Vec2.upLeft,
    Vec2.up,
    Vec2.upRight,
    Vec2.left,
    Vec2.zero,
    Vec2.right,
    Vec2.downLeft,
    Vec2.down,
    Vec2.downRight,
  ];

  static const List<Vec2> aroundDirs = <Vec2>[
    Vec2.upLeft,
    Vec2.up,
    Vec2.upRight,
    Vec2.left,
    Vec2.right,
    Vec2.downLeft,
    Vec2.down,
    Vec2.downRight,
  ];

  static const List<Vec2> orthogonalDirs = [
    Vec2.up,
    Vec2.down,
    Vec2.left,
    Vec2.right,
  ];

  double get magnitude => sqrt(x * x + y * y);

  double get squaredMagnitude => x * x + y * y;

  double get direction => atan2(y, x);

  Vec2 translate(num dx, num dy) => Vec2(x + dx, y + dy);

  Vec2 scale(num scaleX, num scaleY) => Vec2(x * scaleX, y * scaleY);

  double distanceTo(Vec2 other) => (this - other).magnitude;

  double squaredDistanceTo(Vec2 other) => (this - other).squaredMagnitude;

  double manhattanDistanceTo(Vec2 other) =>
      (x - other.x).abs() + (y - other.y).abs();

  double crossProduct(Vec2 other) => x * other.y - y * other.x;

  double dotProduct(Vec2 other) => x * other.x + y * other.y;

  double angle(Vec2 other) => (other - this).direction;

  Vec2 operator +(Vec2 other) => Vec2(x + other.x, y + other.y);

  Vec2 operator -() => Vec2(-x, -y);

  Vec2 operator -(Vec2 other) => Vec2(x - other.x, y - other.y);

  Vec2 operator *(num factor) => Vec2(x * factor, y * factor);

  static Iterable<Vec2> range(Vec2 min, Vec2 max) sync* {
    for (int y = min.yInt; y < max.yInt; y++) {
      for (int x = min.xInt; x < max.xInt; x++) {
        yield Vec2.int(x, y);
      }
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(other, this) ||
      (other is Vec2 &&
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

  final Vec2 from;
  final Vec2 to;

  double get slope => (to.y - from.y) / (to.x - from.x);
  double get intercept => from.y - slope * from.x;
  bool get isOrthogonal => from.x == to.x || from.y == to.y;

  Vec2? intersection(LineSegment2 other) {
    final Vec2 dir = to - from;
    final Vec2 otherDir = other.to - other.from;
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

  double? distanceAlong(Vec2 p) {
    final Vec2 dir = to - from;
    final Vec2 dirP = p - from;
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

  Iterable<Vec2> discretePointsAlong() sync* {
    final double m = slope;
    final double b = intercept;
    if (m.isInfinite) {
      // vertical line
      for (final int y in rangeinc(from.y.truncate(), to.y.truncate())) {
        yield Vec2(from.x, y.toDouble());
      }
    } else {
      for (final int x in rangeinc(from.x.truncate(), to.x.truncate())) {
        final double y = m * x + b;
        if ((y - y.truncateToDouble()).abs() < epsilon) {
          yield Vec2(x.toDouble(), y.truncateToDouble());
        }
      }
    }
  }

  double get manhattanDistance => from.manhattanDistanceTo(to);

  @override
  String toString() => 'Line2($from, $to)';
}
