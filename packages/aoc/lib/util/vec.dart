// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

class Vec {
  const Vec(this.x, this.y);

  final num x;
  final num y;

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
  static const Vec northEast = upRight;
  static const Vec east = right;
  static const Vec southEast = downRight;
  static const Vec south = down;
  static const Vec southWest = downLeft;
  static const Vec west = left;
  static const Vec northWest = upLeft;

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

  num get magnitude => sqrt(x * x + y * y);

  num get squaredMagnitude => x * x + y * y;

  num get direction => atan2(y, x);

  Vec translate(num dx, num dy) => Vec(x + dx, y + dy);

  Vec scale(num scaleX, num scaleY) => Vec(x * scaleX, y * scaleY);

  num distanceTo(Vec other) => (this - other).magnitude;

  num squaredDistanceTo(Vec other) => (this - other).squaredMagnitude;

  num manhattanDistanceTo(Vec other) =>
      (x - other.x).abs() + (y - other.y).abs();

  num crossProduct(Vec other) => x * other.y - y * other.x;

  num dotProduct(Vec other) => x * other.x + y * other.y;

  num angle(Vec other) => (other - this).direction;

  Vec operator +(Vec other) => Vec(x + other.x, y + other.y);

  Vec operator -() => Vec(-x, -y);

  Vec operator -(Vec other) => Vec(x - other.x, y - other.y);

  Vec operator *(num factor) => Vec(x * factor, y * factor);

  static Iterable<Vec> range(Vec min, Vec max) sync* {
    for (int y = min.yInt; y < max.yInt; y++) {
      for (int x = min.xInt; x < max.xInt; x++) {
        yield Vec(x, y);
      }
    }
  }

  @override
  bool operator ==(covariant Vec other) {
    if (identical(this, other)) return true;

    return other.x == x && other.y == y;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  @override
  String toString() => 'Vec($x, $y)';
}
