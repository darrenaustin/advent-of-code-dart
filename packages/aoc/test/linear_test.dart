import 'package:aoc/util/linear.dart';
import 'package:test/test.dart';

main() {
  test('solveLinearSystem', () {
    expect(
        solveLinearSystem([
          [1, 1, 3],
          [3, -2, 4],
        ]).map((n) => n.round()),
        [2, 1]);
    expect(
        solveLinearSystem([
          [2, 1, -1, 8],
          [-3, -1, 2, -11],
          [-2, 1, 2, -3],
        ]).map((n) => n.round()),
        [2, 3, -1]);
  });
}
