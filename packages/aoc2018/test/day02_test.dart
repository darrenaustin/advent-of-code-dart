import 'package:aoc2018/src/day02.dart';
import 'package:test/test.dart';

main() {
  group('2018 Day 02', () {
    group('part 1', () {
      test('example', () {
        final exampleInput = '''
abcdef
bababc
abbcde
abcccd
aabcdd
abcdee
ababab''';
        expect(Day02().part1(exampleInput), 12);
      });

      test('solution', () => Day02().testPart1());
    });

    group('part 2', () {
      test('example', () {
        final exampleInput = '''abcde
fghij
klmno
pqrst
fguij
axcye
wvxyz''';
        expect(Day02().part2(exampleInput), 'fgij');
      });

      test('solution', () => Day02().testPart2());
    });
  });
}
