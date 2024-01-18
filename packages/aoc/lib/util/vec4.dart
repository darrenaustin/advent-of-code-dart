import 'dart:math';

class Vec4 {
  const Vec4([this.x = 0, this.y = 0, this.z = 0, this.w = 0]);

  Vec4.int([int x = 0, int y = 0, int z = 0, int w = 0])
      : x = x.toDouble(),
        y = y.toDouble(),
        z = z.toDouble(),
        w = w.toDouble();

  final double x;
  final double y;
  final double z;
  final double w;

  int get xInt => x.toInt();
  int get yInt => y.toInt();
  int get zInt => z.toInt();
  int get wInt => w.toInt();

  double get magnitude => sqrt(x * x + y * y + z * z + w * w);

  double get squaredMagnitude => x * x + y * y + z * z + w * w;

  static const zero = Vec4();

  Vec4 translate(num dx, num dy, num dz, num dw) =>
      Vec4(x + dx, y + dy, z + dz, w + dw);

  Vec4 scale(num scaleX, num scaleY, num scaleZ, num scaleW) =>
      Vec4(x * scaleX, y * scaleY, z * scaleZ, w * scaleW);

  double distanceTo(Vec4 other) => (this - other).magnitude;

  double squaredDistanceTo(Vec4 other) => (this - other).squaredMagnitude;

  double manhattanDistanceTo(Vec4 other) =>
      (x - other.x).abs() +
      (y - other.y).abs() +
      (z - other.z).abs() +
      (w - other.w).abs();

  double dotProduct(Vec4 other) =>
      x * other.x + y * other.y + z * other.z + w * other.w;

  Vec4 operator +(Vec4 other) =>
      Vec4(x + other.x, y + other.y, z + other.z, w + other.w);

  Vec4 operator -() => Vec4(-x, -y, -z, -w);

  Vec4 operator -(Vec4 other) =>
      Vec4(x - other.x, y - other.y, z - other.z, w - other.w);

  Vec4 operator *(num factor) =>
      Vec4(x * factor, y * factor, z * factor, w * factor);

  @override
  bool operator ==(Object other) =>
      identical(other, this) ||
      (other is Vec4 &&
          other.runtimeType == runtimeType &&
          other.x == x &&
          other.y == y &&
          other.z == z &&
          other.w == w);

  @override
  int get hashCode => x.hashCode ^ y.hashCode ^ z.hashCode ^ w.hashCode;

  @override
  String toString() => 'Vec4($x, $y, $z, $w)';
}
