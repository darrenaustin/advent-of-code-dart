import 'package:aoc2015/src/day02.dart';
import 'package:test/test.dart';

main() {
  group('2015 Day 02', () {
    group('part 1', () {
      test('examples', () {
        expect(Day02.wrapNeededFor(Day02.parsePackage('2x3x4')), 58); 
        expect(Day02.wrapNeededFor(Day02.parsePackage('1x1x10')), 43); 
      });

      test('solution', () => Day02().testPart1());
    });

    group('part 2', () {
      test('examples', () {
        expect(Day02.ribbonNeededFor(Day02.parsePackage('2x3x4')), 34); 
        expect(Day02.ribbonNeededFor(Day02.parsePackage('1x1x10')), 14); 
      });

      test('solution', () => Day02().testPart2());
    });
  });
}