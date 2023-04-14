import 'package:aoc2018/src/day04.dart';
import 'package:test/test.dart';

main() {
  group('2018 Day 04', () {
    final exampleInput = '''
[1518-11-01 00:00] Guard #10 begins shift
[1518-11-01 00:05] falls asleep
[1518-11-01 00:25] wakes up
[1518-11-01 00:30] falls asleep
[1518-11-01 00:55] wakes up
[1518-11-01 23:58] Guard #99 begins shift
[1518-11-02 00:40] falls asleep
[1518-11-02 00:50] wakes up
[1518-11-03 00:05] Guard #10 begins shift
[1518-11-03 00:24] falls asleep
[1518-11-03 00:29] wakes up
[1518-11-04 00:02] Guard #99 begins shift
[1518-11-04 00:36] falls asleep
[1518-11-04 00:46] wakes up
[1518-11-05 00:03] Guard #99 begins shift
[1518-11-05 00:45] falls asleep
[1518-11-05 00:55] wakes up''';
    group('part 1', () {
      test('example', () {
        expect(Day04().part1(exampleInput), 240);
      });

      test('solution', () => Day04().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day04().part2(exampleInput), 4455);
      });

      test('solution', () => Day04().testPart2());
    });
  });
}
