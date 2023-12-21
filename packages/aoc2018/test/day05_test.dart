import 'package:aoc2018/src/day05.dart';
import 'package:test/test.dart';

main() {
  group('2018 Day 05', () {
    group('part 1', () {
      test('example', () {
        expect(Day05().part1('aA'), 0);
        expect(Day05().part1('abBA'), 0);
        expect(Day05().part1('abAB'), 4);
        expect(Day05().part1('aabAAB'), 6);
        expect(Day05().part1('dabAcCaCBAcCcaDA'), 10);
      });

      test('solution', () => Day05().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day05().part2('dabAcCaCBAcCcaDA'), 4);
      });

      test('solution', () => Day05().testPart2());
    });
  });
}
