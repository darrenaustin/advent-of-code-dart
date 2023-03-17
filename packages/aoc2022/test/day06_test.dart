import 'package:aoc2022/src/day06.dart';
import 'package:test/test.dart';

main() {
  group('2022 Day 06', () {
    group('part 1', () {
      test('examples', () {
        expect(Day06().part1('mjqjpqmgbljsphdztnvjfqwrcgsmlb'), 7);
        expect(Day06().part1('bvwbjplbgvbhsrlpgdmjqwftvncz'), 5);
        expect(Day06().part1('nppdvjthqldpwncqszvftbrmjlhg'), 6);
        expect(Day06().part1('nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg'), 10);
        expect(Day06().part1('zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw'), 11);
      });

      test('solution', () => Day06().testPart1());
    });

    group('part 2', () {
      test('examples', () {
        expect(Day06().part2('mjqjpqmgbljsphdztnvjfqwrcgsmlb'), 19);
        expect(Day06().part2('bvwbjplbgvbhsrlpgdmjqwftvncz'), 23);
        expect(Day06().part2('nppdvjthqldpwncqszvftbrmjlhg'), 23);
        expect(Day06().part2('nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg'), 29);
        expect(Day06().part2('zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw'), 26);
      });

      test('solution', () => Day06().testPart2());
    });
  });
}
