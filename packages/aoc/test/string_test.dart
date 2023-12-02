import 'package:aoc/util/string.dart';
import 'package:test/test.dart';

main() {
  group('String extensions', () {
    test('chars', () {
      expect('123abc'.chars, ['1', '2', '3', 'a', 'b', 'c']);
      expect(''.chars, []);
    });

    test('lines', () {
      expect('123\nabc\n10'.lines, ['123', 'abc', '10']);
      expect('\nabc\n\n10\n'.lines, ['', 'abc', '', '10', '']);
    });
  });

  group('RegExp extensions', () {
    test('allStringMatches', () {
      expect(
          RegExp(r'[\d]').allStringMatches('a1b2c3d4'), ["1", "2", "3", "4"]);
      expect(
          RegExp(r'[a-z]').allStringMatches('a1b2c3d4'), ["a", "b", "c", "d"]);
      expect(RegExp(r'[a-z]').allStringMatches('1234'), []);

      // Doesn't see overlapping matches.
      expect(RegExp(r'one|eight').allStringMatches('oneight'), ["one"]);
    });

    test('allOverlappingStringMatches', () {
      expect(RegExp(r'[\d]').allOverlappingStringMatches('a1b2c3d4'),
          ["1", "2", "3", "4"]);
      expect(RegExp(r'[a-z]').allOverlappingStringMatches('a1b2c3d4'),
          ["a", "b", "c", "d"]);
      expect(RegExp(r'[a-z]').allOverlappingStringMatches('1234'), []);
      expect(
          RegExp(r'one|eight|teen').allOverlappingStringMatches('oneighteen'),
          ["one", "eight", "teen"]);
    });
  });
}
