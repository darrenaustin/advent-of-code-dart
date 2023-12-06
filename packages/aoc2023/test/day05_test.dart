import 'package:aoc2023/src/day05.dart';
import 'package:test/test.dart';

main() {
  group('2023 Day 05', () {
    final String exampleInput = '''
seeds: 79 14 55 13

seed-to-soil map:
50 98 2
52 50 48

soil-to-fertilizer map:
0 15 37
37 52 2
39 0 15

fertilizer-to-water map:
49 53 8
0 11 42
42 0 7
57 7 4

water-to-light map:
88 18 7
18 25 70

light-to-temperature map:
45 77 23
81 45 19
68 64 13

temperature-to-humidity map:
0 69 1
1 0 69

humidity-to-location map:
60 56 37
56 93 4''';

    group('Range', () {
      test('intersect completely outside', () {
        final range = Range(start: 10, end: 20);
        {
          final lowerRange = Range(start: 0, end: 9);
          final (inside, outside) = range.intersect(lowerRange);
          expect(inside, isNull);
          expect(outside, [lowerRange]);
        }
        {
          final higherRange = Range(start: 21, end: 30);
          final (inside, outside) = range.intersect(higherRange);
          expect(inside, isNull);
          expect(outside, [higherRange]);
        }
      });

      test('intersect completely inside', () {
        final range = Range(start: 10, end: 20);
        {
          // Range intersecting itself
          final (inside, outside) = range.intersect(range);
          expect(inside, range);
          expect(outside, []);
        }
        {
          // Touches starting edge
          final subsetRange = Range(start: 10, end: 15);
          final (inside, outside) = range.intersect(subsetRange);
          expect(inside, subsetRange);
          expect(outside, []);
        }
        {
          // Fully inside
          final subsetRange = Range(start: 11, end: 19);
          final (inside, outside) = range.intersect(subsetRange);
          expect(inside, subsetRange);
          expect(outside, []);
        }
        {
          // Touches ending edge
          final subsetRange = Range(start: 15, end: 20);
          final (inside, outside) = range.intersect(subsetRange);
          expect(inside, subsetRange);
          expect(outside, []);
        }
      });

      test('intersect with start side', () {
        final range = Range(start: 10, end: 20);
        {
          // Right up against the start
          final startingRange = Range(start: 5, end: 10);
          final (inside, outside) = range.intersect(startingRange);
          expect(inside, Range(start: 10, end: 10));
          expect(outside, [Range(start: 5, end: 9)]);
        }
        {
          // Crossing the start
          final startingRange = Range(start: 5, end: 15);
          final (inside, outside) = range.intersect(startingRange);
          expect(inside, Range(start: 10, end: 15));
          expect(outside, [Range(start: 5, end: 9)]);
        }
        {
          // Right up against the end
          final startingRange = Range(start: 5, end: 20);
          final (inside, outside) = range.intersect(startingRange);
          expect(inside, range);
          expect(outside, [Range(start: 5, end: 9)]);
        }
      });

      test('intersect with end side', () {
        final range = Range(start: 10, end: 20);
        {
          // Right up against the end
          final endingRange = Range(start: 20, end: 25);
          final (inside, outside) = range.intersect(endingRange);
          expect(inside, Range(start: 20, end: 20));
          expect(outside, [Range(start: 21, end: 25)]);
        }
        {
          // Crossing the end
          final endingRange = Range(start: 15, end: 25);
          final (inside, outside) = range.intersect(endingRange);
          expect(inside, Range(start: 15, end: 20));
          expect(outside, [Range(start: 21, end: 25)]);
        }
        {
          // Right up against the start
          final endingRange = Range(start: 10, end: 25);
          final (inside, outside) = range.intersect(endingRange);
          expect(inside, range);
          expect(outside, [Range(start: 21, end: 25)]);
        }
      });

      test('intersect across whole range', () {
        final range = Range(start: 10, end: 20);
        // Crossing both start and end of range.
        final superSetRange = Range(start: 0, end: 30);
        final (inside, outside) = range.intersect(superSetRange);
        expect(inside, range);
        expect(outside, {Range(start: 0, end: 9), Range(start: 21, end: 30)});
      });
    });

    group('part 1', () {
      test('example', () {
        expect(Day05().part1(exampleInput), 35);
      });

      test('solution', () => Day05().testPart1());
    });

    group('part 2', () {
      test('example', () {
        expect(Day05().part2(exampleInput), 46);
      });

      test('solution', () => Day05().testPart2());
    });
  });
}
