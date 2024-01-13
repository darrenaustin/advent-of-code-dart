import 'package:aoc/util/collection.dart';
import 'package:test/test.dart';

main() {
  group('frequencies', () {
    test('with characters', () {
      expect(frequencies(<String>[]), {});
      expect(frequencies('abc'.split('')), {'a': 1, 'b': 1, 'c': 1});
      expect(frequencies('aacbc'.split('')), {'a': 2, 'b': 1, 'c': 2});
      expect(frequencies('aaaAA'.split('')), {'a': 3, 'A': 2});
    });

    test('with numbers', () {
      expect(frequencies(<int>[]), {});
      expect(frequencies([1, 2, 3]), {1: 1, 2: 1, 3: 1});
      expect(frequencies([1, 2, 3, 2, 1]), {1: 2, 2: 2, 3: 1});
      expect(frequencies([-1, 2, -1, 2, -1]), {-1: 3, 2: 2});
    });
  });

  group('List extensions', () {
    test('repeat', () {
      expect([1, 2, 3].repeat(4), [1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3]);
      expect([].repeat(3), []);
      expect([1, 2, 3].repeat(0), []);
      expect([1, 2, 3].repeat(-1), []);
    });
  });

  group('Set extensions', () {
    test('equals', () {
      expect({1, 2, 3}.equals({1, 2, 3}), isTrue);
      expect({1, 2, 3, 4}.equals({1, 2, 3}), isFalse);
      expect({1, 2, 3}.equals({0, 1, 2, 3}), isFalse);
      expect(<int>{}.equals({}), isTrue);
      expect(<int>{}.equals({1}), isFalse);
      final a = {1, 2, 3};
      a.remove(2);
      expect(a.equals({1, 3}), isTrue);
    });

    test('removeFirst', () {
      final s = {1, 2, 3};
      final origFirst = s.first;
      final removedFirst = s.removeFirst();
      expect(removedFirst, origFirst);
      expect(s.contains(origFirst), isFalse);
      expect(s.length, 2);
    });
  });
}
