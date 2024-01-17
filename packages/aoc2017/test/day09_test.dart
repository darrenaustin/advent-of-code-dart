import 'package:aoc2017/src/day09.dart';
import 'package:test/test.dart';

main() {
  group('2017 Day 09', () {
    group('part 1', () {
      test('example', () {
        expect(Day09().part1('{}'), 1);
        expect(Day09().part1('{{{}}}'), 6);
        expect(Day09().part1('{{},{}}'), 5);
        expect(Day09().part1('{{{},{},{{}}}}'), 16);
        expect(Day09().part1('{<a>,<a>,<a>,<a>}'), 1);
        expect(Day09().part1('{{<ab>},{<ab>},{<ab>},{<ab>}}'), 9);
        expect(Day09().part1('{{<!!>},{<!!>},{<!!>},{<!!>}}'), 9);
        expect(Day09().part1('{{<a!>},{<a!>},{<a!>},{<ab>}}'), 3);
      });

      test('solution', () => Day09().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day09().part2('<>'), 0);
        expect(Day09().part2('<random characters>'), 17);
        expect(Day09().part2('<<<<>'), 3);
        expect(Day09().part2('<{!>}>'), 2);
        expect(Day09().part2('<!!>'), 0);
        expect(Day09().part2('<!!!>>'), 0);
        expect(Day09().part2('<{o"i!a,<{i<a>'), 10);
      });

      test('solution', () => Day09().testPart2());
    });
  });
}
