import 'package:aoc2016/src/day07.dart';
import 'package:test/test.dart';

main() {
  group('2016 Day 07', () {
    group('part 1', () {
      test('examples', () {
        expect(Day07.supportsTLS('abba[mnop]qrst'), true); 
        expect(Day07.supportsTLS('abcd[bddb]xyyx'), false); 
        expect(Day07.supportsTLS('aaaa[qwer]tyui'), false); 
        expect(Day07.supportsTLS('ioxxoj[asdfgh]zxcvbn'), true); 
      });

      test('solution', () => Day07().testPart1());
    });

    group('part 2', () {
      test('examples', () {
        expect(Day07.supportsSSL('aba[bab]xyz'), true); 
        expect(Day07.supportsSSL('xyx[xyx]xyx'), false); 
        expect(Day07.supportsSSL('aaa[kek]eke'), true); 
        expect(Day07.supportsSSL('zazbz[bzb]cdb'), true); 
      });

      test('solution', () => Day07().testPart2());
    });
  });
}
