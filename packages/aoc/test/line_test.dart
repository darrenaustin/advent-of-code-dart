import 'package:aoc/util/line.dart';
import 'package:aoc/util/vec.dart';
import 'package:test/test.dart';

main() {
  group('Line', () {
    test('discretePointAlong orthogonal', () {
      final horizontalLine = Line(Vec(0, 9), Vec(5, 9));
      expect(horizontalLine.discretePointsAlong(),
          List.generate(6, (x) => Vec(x, 9)));

      final verticalLine = Line(Vec(42, 3), Vec(42, -3));
      expect(verticalLine.discretePointsAlong(),
          List.generate(7, (y) => Vec(42, 3 - y)));
    });
  });
}
