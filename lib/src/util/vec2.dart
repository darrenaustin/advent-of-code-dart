import 'dart:math';

import 'package:meta/meta.dart';

import 'collection.dart';
import 'math.dart';

@immutable
class Vector {
  const Vector(this.x, this.y);

  Vector.int(int x, int y)
      : x = x.toDouble(),
        y = y.toDouble();

  final double x;
  final double y;

  double get magnitude => sqrt(x * x + y * y);

  double get squaredMagnitude => x * x + y * y;

  double get direction => atan2(y, x);

  static const Vector zero = Vector(0, 0);

  Vector translate(num dx, num dy) => Vector(x + dx, y + dy);

  Vector scale(num scaleX, num scaleY) => Vector(x * scaleX, y * scaleY);

  double distanceTo(Vector other) => (this - other).magnitude;

  double squaredDistanceTo(Vector other) => (this - other).squaredMagnitude;

  double manhattanDistanceTo(Vector other) => (x - other.x).abs() + (y - other.y).abs();

  double crossProduct(Vector other) => x * other.y - y * other.x;

  double dotProduct(Vector other) => x * other.x + y * other.y;

  double angle(Vector other) => (other - this).direction;

  Vector operator +(Vector other) {
    return Vector(x + other.x, y + other.y);
  }

  Vector operator -() => Vector(-x, -y);

  Vector operator -(Vector other) {
    return Vector(x - other.x, y - other.y);
  }

  Vector operator *(num factor) {
    return Vector(x * factor, y * factor);
  }

  @override
  bool operator ==(Object other) {
    return other is Vector
        && other.x == x
        && other.y == y;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  @override
  String toString() => 'Vector($x, $y)';
}

class LineSegment {
  LineSegment(this.from, this.to);

  final Vector from;
  final Vector to;

  double get slope => (to.y - from.y) / (to.x - from.x);
  double get intercept => from.y - slope * from.x;

  Vector? intersection(LineSegment other) {
    final Vector dir = to - from;
    final Vector otherDir = other.to - other.from;
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

  double? distanceAlong(Vector p) {
    final Vector dir = to - from;
    final Vector dirP = p - from;
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

  Iterable<Vector> discretePointsAlong() sync* {
    final double m = slope;
    final double b = intercept;
    if (slope.isInfinite) {
      final int inc = (to.y - from.y).sign.toInt();
      for (final int y in range(from.y.truncate() + inc, to.y.truncate() + inc, inc)) {
        yield Vector(from.x, y.toDouble());
      }
    } else {
      final int inc = (to.x - from.x).sign.toInt();
      for (final int x in range(from.x.truncate() + inc, to.x.truncate() + inc, inc)) {
        final double y = m * x + b;
        if ((y - y.truncateToDouble()).abs() < epsilon) {
          yield Vector(x.toDouble(), y.truncateToDouble());
        }
      }
    }
  }

  double get manhattanDistance => from.manhattanDistanceTo(to);

  @override
  String toString() => 'LineSegment($from, $to)';
}
