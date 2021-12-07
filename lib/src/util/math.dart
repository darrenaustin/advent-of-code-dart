import 'dart:math';

const double epsilon = 4.94065645841247E-16;
const double twoPi = pi * 2;

double toDegrees(double radians) => radians * 180 / pi;
double toRadians(double degrees) => degrees * pi / 180;

int lcm(int a, int b) => (a * b) ~/ a.gcd(b);
int gcd(int a, int b) => a.gcd(b);

T? minOrNull<T extends num>(T? a, T? b) {
  if (a != null && b != null) {
    return min(a, b);
  }
  return a ?? b;
}

T? maxOrNull<T extends num>(T? a, T? b) {
  if (a != null && b != null) {
    return max(a, b);
  }
  return a ?? b;
}

int sign(num n) {
  return n == 0 ? 0 : n > 0 ? 1 : -1;
}

num abs(num n) {
  return n < 0 ? -n : n;
}
