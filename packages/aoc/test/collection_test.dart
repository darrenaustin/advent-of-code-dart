import 'package:aoc/util/collection.dart';
import 'package:test/test.dart';

main() {
  group('range', () {
    test('with just end', () {
      expect(range(10), [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]);
      expect(range(0), []);
      expect(range(-10), [0, -1, -2, -3, -4, -5, -6, -7, -8, -9]);
    });

    test('with start and end', () {
      expect(range(42, 47), [42, 43, 44, 45, 46]);
      expect(range(42, 42), []);
      expect(range(47, 42), [47, 46, 45, 44, 43]);
    });

    test('with start, end and step', () {
      expect(range(42, 47, 2), [42, 44, 46]);
      expect(range(42, 42, 10), []);
      expect(range(47, 42, 2), []);
      expect(range(47, 42, -2), [47, 45, 43]);
    });
  });
}
