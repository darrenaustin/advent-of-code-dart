// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

class Vec3 {
  const Vec3(this.x, this.y, this.z);

  Vec3.int(int x, int y, int z)
      : x = x.toDouble(),
        y = y.toDouble(),
        z = z.toDouble();

  final double x;
  final double y;
  final double z;

  int get xInt => x.toInt();
  int get yInt => y.toInt();
  int get zInt => z.toInt();

  double get magnitude => sqrt(x * x + y * y + z * z);

  double get squaredMagnitude => x * x + y * y + z * z;

  static const zero = Vec3(0, 0, 0);

  Vec3 translate(num dx, num dy, num dz) => Vec3(x + dx, y + dy, z + dz);

  Vec3 scale(num scaleX, num scaleY, num scaleZ) =>
      Vec3(x * scaleX, y * scaleY, z * scaleZ);

  double distanceTo(Vec3 other) => (this - other).magnitude;

  Vec3 directionTo(Vec3 other) =>
      Vec3((other.x - x).sign, (other.y - y).sign, (other.z - z).sign);

  double squaredDistanceTo(Vec3 other) => (this - other).squaredMagnitude;

  double manhattanDistanceTo(Vec3 other) =>
      (x - other.x).abs() + (y - other.y).abs() + (z - other.z).abs();

  Vec3 crossProduct(Vec3 other) => Vec3(
        y * other.z - z * other.y,
        z * other.x - x * other.z,
        x * other.y - y * other.x,
      );

  double dotProduct(Vec3 other) => x * other.x + y * other.y + z * other.z;

  Vec3 operator +(Vec3 other) => Vec3(x + other.x, y + other.y, z + other.z);

  Vec3 operator -() => Vec3(-x, -y, -z);

  Vec3 operator -(Vec3 other) => Vec3(x - other.x, y - other.y, z - other.z);

  Vec3 operator *(num factor) => Vec3(x * factor, y * factor, z * factor);

  @override
  bool operator ==(covariant Vec3 other) {
    if (identical(this, other)) return true;

    return other.x == x && other.y == y && other.z == z;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode ^ z.hashCode;

  @override
  String toString() => 'Vec3($x, $y, $z)';
}
