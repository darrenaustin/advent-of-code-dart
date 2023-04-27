import 'package:aoc2016/src/day21.dart';
import 'package:test/test.dart';

main() {
  final exampleInput = '''
swap position 4 with position 0
swap letter d with letter b
reverse positions 0 through 4
rotate left 1 step
move position 1 to position 4
move position 3 to position 0
rotate based on position of letter b
rotate based on position of letter d''';

  group('2016 Day 21', () {
    group('operations', () {
      test('swapPostions', () {
        expect('abcde'.swapPositions(4, 0), 'ebcda');
      });
      test('swapLetter', () {
        expect('ebcda'.swapLetters('d', 'b'), 'edcba');
      });
      test('rotate', () {
        expect('abcde'.rotate(-1), 'bcdea');
        expect('abcde'.rotate(2), 'deabc');
        expect('abcde'.rotate(-10), 'abcde');
      });
      test('rotateAroundLetter', () {
        expect('abdec'.rotateAroundLetter('b'), 'ecabd');
        expect('ecabd'.rotateAroundLetter('d'), 'decab');
        expect('fgabedch'.rotateAroundLetter('d'), 'gabedchf');
      });
      test('reverseRotateAroundLetter', () {
        expect('gabedchf'.reverseRotateAroundLetter('d'), 'fgabedch');
      });
      test('reversePositions', () {
        expect('edcba'.reversePositions(0, 4), 'abcde');
        expect('abcedf'.reversePositions(1, 4), 'adecbf');
        expect('abcedf'.reversePositions(1, 2), 'acbedf');
        expect('abcedf'.reversePositions(1, 3), 'aecbdf');

      });
      test('movePosition', () {
        expect('bcdea'.movePosition(1, 4), 'bdeac');
        expect('bdeac'.movePosition(3, 0), 'abdec');
      });
    });

    group('part 1', () {
      test('example', () {
        expect(Day21().part1(exampleInput, 'abcde'), 'decab');
      });

      test('solution', () => Day21().testPart1());
    });

    group('part 2', () {
      test('example', () {
        final day = Day21();
        expect(day.part2(day.input(), 'gcedfahb'), 'abcdefgh');
      });

      test('solution', () => Day21().testPart2());
    });
  });
}
