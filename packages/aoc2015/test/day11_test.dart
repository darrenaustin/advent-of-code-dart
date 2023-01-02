import 'package:aoc2015/src/day11.dart';
import 'package:test/test.dart';

main() {
  group('2015 Day 11', () {
    group('part 1', () {
      test('example', () {
        expect(Day11.validPassword('hijklmmn'), false);
        expect(Day11.validPassword('abbceffg'), false);
        expect(Day11.validPassword('abbcegjk'), false);
        expect(Day11.nextValidPassword('abcdefgh'), 'abcdffaa');
        expect(Day11.nextValidPassword('ghijklmn'), 'ghjaabcc');
      });

      test('solution', () => Day11().testPart1());
    });

    group('part 2', () {
      test('solution', () => Day11().testPart2());
    });
  });
}