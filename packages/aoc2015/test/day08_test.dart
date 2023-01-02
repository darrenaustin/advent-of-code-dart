import 'package:aoc2015/src/day08.dart';
import 'package:test/test.dart';

main() {
  group('2015 Day 08', () {
    group('part 1', () {
      test('examples', () {
        expect(Day08.unescape(r'""').length, 0); 
        expect(Day08.unescape(r'"abc"').length, 3); 
        expect(Day08.unescape(r'"aaa\"aaa"').length, 7); 
        expect(Day08.unescape(r'"\x27"').length, 1); 
      });

      test('solution', () => Day08().testPart1());
    });

    group('part 2', () {
      test('examples', () {
        expect(Day08.escape(r'""').length, 6); 
        expect(Day08.escape(r'"abc"').length, 9); 
        expect(Day08.escape(r'"aaa\"aaa"').length, 16); 
        expect(Day08.escape(r'"\x27"').length, 11); 
      });

      test('solution', () => Day08().testPart2());
    });
  });
}