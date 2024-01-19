import 'dart:math';

class Vec4 {
  const Vec4([this.x = 0, this.y = 0, this.z = 0, this.w = 0]);

  final num x;
  final num y;
  final num z;
  final num w;

  int get xInt => x.toInt();
  int get yInt => y.toInt();
  int get zInt => z.toInt();
  int get wInt => w.toInt();

  static const zero = Vec4();

  num get magnitude => sqrt(x * x + y * y + z * z + w * w);

  num get squaredMagnitude => x * x + y * y + z * z + w * w;

  Vec4 translate(num dx, num dy, num dz, num dw) =>
      Vec4(x + dx, y + dy, z + dz, w + dw);

  Vec4 scale(num scaleX, num scaleY, num scaleZ, num scaleW) =>
      Vec4(x * scaleX, y * scaleY, z * scaleZ, w * scaleW);

  num distanceTo(Vec4 other) => (this - other).magnitude;

  num squaredDistanceTo(Vec4 other) => (this - other).squaredMagnitude;

  num manhattanDistanceTo(Vec4 other) =>
      (x - other.x).abs() +
      (y - other.y).abs() +
      (z - other.z).abs() +
      (w - other.w).abs();

  num dotProduct(Vec4 other) =>
      x * other.x + y * other.y + z * other.z + w * other.w;

  Vec4 operator +(Vec4 other) =>
      Vec4(x + other.x, y + other.y, z + other.z, w + other.w);

  Vec4 operator -() => Vec4(-x, -y, -z, -w);

  Vec4 operator -(Vec4 other) =>
      Vec4(x - other.x, y - other.y, z - other.z, w - other.w);

  Vec4 operator *(num factor) =>
      Vec4(x * factor, y * factor, z * factor, w * factor);

  @override
  bool operator ==(covariant Vec4 other) {
    if (identical(this, other)) return true;

    return other.x == x && other.y == y && other.z == z && other.w == w;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode ^ z.hashCode ^ w.hashCode;

  @override
  String toString() => 'Vec4($x, $y, $z, $w)';
}
