import 'package:aoc2017/src/day04.dart';
import 'package:test/test.dart';

main() {
  group('2017 Day 04', () {
    group('part 1', () {
      test('examples', () {
        expect(Day04.validPassphrase('aa bb cc dd ee'), true); 
        expect(Day04.validPassphrase('aa bb cc dd aa'), false); 
        expect(Day04.validPassphrase('aa bb cc dd aaa'), true); 
      });

      test('solution', () => Day04().testPart1());
    });

    group('part 2', () {
      test('examples', () {
        expect(Day04.validAnagramPassphrase('abcde fghij'), true); 
        expect(Day04.validAnagramPassphrase('abcde xyz ecdab'), false); 
        expect(Day04.validAnagramPassphrase('a ab abc abd abf abj'), true); 
        expect(Day04.validAnagramPassphrase('iiii oiii ooii oooi oooo'), true); 
        expect(Day04.validAnagramPassphrase('oiii ioii iioi iiio'), false); 
      });

      test('solution', () => Day04().testPart2());
    });
  });
}
