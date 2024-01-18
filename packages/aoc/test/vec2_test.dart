import 'package:aoc/util/vec2.dart';
import 'package:test/test.dart';

main() {
  group('LineSegment', () {
    test('discretePointAlong orthogonal', () {
      final horizontalLine = LineSegment2(Vec2(0, 9), Vec2(5, 9));
      expect(horizontalLine.discretePointsAlong(),
          List.generate(6, (x) => Vec2.int(x, 9)));

      final verticalLine = LineSegment2(Vec2(42, 3), Vec2(42, -3));
      expect(verticalLine.discretePointsAlong(),
          List.generate(7, (y) => Vec2.int(42, 3 - y)));
    });
  });
}
