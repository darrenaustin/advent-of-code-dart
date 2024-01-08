import 'dart:math';

const int maxInt = 9223372036854775807;
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

Iterable<int> divisors(int n, [bool proper = false]) {
  final divisors = [1, if (!proper) n];
  final limit = sqrt(n).floor();
  for (int f = 2; f <= limit; f++) {
    if (n % f == 0) {
      final factor = n ~/ f;
      divisors.add(factor);
      if (factor != f) {
        divisors.add(f);
      }
    }
  }
  return divisors;
}

extension NumExtention on num {
  bool get isInteger => this is int || this == truncateToDouble();

  bool get effectivelyZero => abs() < epsilon;
}
