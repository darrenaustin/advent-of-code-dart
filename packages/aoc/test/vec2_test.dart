import 'package:aoc/util/vec.dart';
import 'package:test/test.dart';

main() {
  group('LineSegment', () {
    test('discretePointAlong orthogonal', () {
      final horizontalLine = LineSegment2(Vec(0, 9), Vec(5, 9));
      expect(horizontalLine.discretePointsAlong(),
          List.generate(6, (x) => Vec.int(x, 9)));

      final verticalLine = LineSegment2(Vec(42, 3), Vec(42, -3));
      expect(verticalLine.discretePointsAlong(),
          List.generate(7, (y) => Vec.int(42, 3 - y)));
    });
  });
}
