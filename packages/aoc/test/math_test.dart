import 'package:aoc/util/math.dart';
import 'package:test/test.dart';

main() {
  test('divisors', () {
    expect(divisors(1), {1});
    expect(divisors(2), {1, 2});
    expect(divisors(8), {1, 2, 4, 8});
    expect(divisors(10), {1, 2, 5, 10});
    expect(divisors(25), {1, 5, 25});
    expect(divisors(25, true), {1, 5});
    expect(divisors(1000),
        {1, 2, 4, 5, 8, 10, 20, 25, 40, 50, 100, 125, 200, 250, 500, 1000});
  });
}
