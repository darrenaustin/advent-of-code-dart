import 'package:aoc/util/range.dart';
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
  });

  group('rangeinc', () {
    test('with just end', () {
      expect(rangeinc(10), [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
      expect(rangeinc(0), [0]);
      expect(rangeinc(-10), [0, -1, -2, -3, -4, -5, -6, -7, -8, -9, -10]);
    });

    test('with start and end', () {
      expect(rangeinc(42, 47), [42, 43, 44, 45, 46, 47]);
      expect(rangeinc(42, 42), [42]);
      expect(rangeinc(47, 42), [47, 46, 45, 44, 43, 42]);
    });
  });

  group('Range', () {
    test('contains', () {
      expect(Range(10).contains(0), isTrue);
      expect(Range(10).contains(5), isTrue);
      expect(Range(10).contains(9), isTrue);
      expect(Range(10).contains(10), isFalse);
      expect(Range(10).contains(-1), isFalse);

      expect(Range(-10).contains(0), isTrue);
      expect(Range(-10).contains(-5), isTrue);
      expect(Range(-10).contains(-9), isTrue);
      expect(Range(-10).contains(-10), isFalse);
      expect(Range(-10).contains(1), isFalse);

      expect(Range(42, 47).contains(41), isFalse);
      expect(Range(42, 47).contains(42), isTrue);
      expect(Range(42, 47).contains(44), isTrue);
      expect(Range(42, 47).contains(46), isTrue);
      expect(Range(42, 47).contains(47), isFalse);

      expect(Range(42, 42).contains(42), isFalse);
      expect(Range(42, 42).contains(41), isFalse);
      expect(Range(42, 42).contains(43), isFalse);

      expect(Range(47, 42).contains(48), isFalse);
      expect(Range(47, 42).contains(47), isTrue);
      expect(Range(47, 42).contains(45), isTrue);
      expect(Range(47, 42).contains(43), isTrue);
      expect(Range(47, 42).contains(42), isFalse);

      expect(Range.inc(10).contains(0), isTrue);
      expect(Range.inc(10).contains(5), isTrue);
      expect(Range.inc(10).contains(9), isTrue);
      expect(Range.inc(10).contains(10), isTrue);
      expect(Range.inc(10).contains(-1), isFalse);

      expect(Range.inc(-10).contains(0), isTrue);
      expect(Range.inc(-10).contains(-5), isTrue);
      expect(Range.inc(-10).contains(-9), isTrue);
      expect(Range.inc(-10).contains(-10), isTrue);
      expect(Range.inc(-10).contains(1), isFalse);

      expect(Range.inc(42, 47).contains(41), isFalse);
      expect(Range.inc(42, 47).contains(42), isTrue);
      expect(Range.inc(42, 47).contains(44), isTrue);
      expect(Range.inc(42, 47).contains(46), isTrue);
      expect(Range.inc(42, 47).contains(47), isTrue);
      expect(Range.inc(42, 47).contains(48), isFalse);

      expect(Range.inc(42, 42).contains(42), isTrue);
      expect(Range.inc(42, 42).contains(41), isFalse);
      expect(Range.inc(42, 42).contains(43), isFalse);

      expect(Range.inc(47, 42).contains(48), isFalse);
      expect(Range.inc(47, 42).contains(47), isTrue);
      expect(Range.inc(47, 42).contains(45), isTrue);
      expect(Range.inc(47, 42).contains(43), isTrue);
      expect(Range.inc(47, 42).contains(42), isTrue);
      expect(Range.inc(47, 42).contains(41), isFalse);
    });

    test('toString', () {
      expect(Range(10).toString(), 'Range(0..10)');
      expect(Range(47, 42).toString(), 'Range(47..42)');
      expect(Range(-10).toString(), 'Range(0..-10)');
      expect(Range(-10, 10).toString(), 'Range(-10..10)');
      expect(Range(0).toString(), 'Range(0..0)');
      expect(Range.inc(10).toString(), 'Range(0..11)');
      expect(Range.inc(47, 42).toString(), 'Range(47..41)');
      expect(Range.inc(-10).toString(), 'Range(0..-11)');
      expect(Range.inc(-10, 10).toString(), 'Range(-10..11)');
      expect(Range.inc(0).toString(), 'Range(0..1)');
    });
  });
}
