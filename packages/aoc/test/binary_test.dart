import 'package:aoc/util/binary.dart';
import 'package:aoc/util/collection.dart';
import 'package:aoc/util/math.dart';
import 'package:test/test.dart';

main() {
  group('Binary int extension', () {
    test('bits', () {
      expect(0.bits, [0]);
      expect(1.bits, [1]);
      expect(5.bits, [1, 0, 1]);
      expect(32.bits, [1, 0, 0, 0, 0, 0]);
      expect(maxInt.bits, [1].repeat(63));
      expect(() => (-1).bits, throwsArgumentError);
    });
  });
}
