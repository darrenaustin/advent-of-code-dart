// https://adventofcode.com/2016/day/20

import 'dart:math';

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';

main() => Day20().solve();

class Day20 extends AdventDay {
  Day20() : super(2016, 20, name: 'Firewall Rules');

  @override
  dynamic part1(String input) => parseRanges(input)[0].last + 1;

  @override
  dynamic part2(String input, [int maxValue = 4294967295]) {
    final ranges = parseRanges(input);
    int numAllowed = ranges.first.first == 0 ? 0 : ranges.first.first;
    for (int i = 1; i < ranges.length; i++) {
      final low = ranges[i - 1];
      final high = ranges[i];
      numAllowed += high.first - low.last - 1;
    }
    if (ranges.last.last < maxValue) {
      numAllowed += maxValue - ranges.last.last;
    }
    return numAllowed;
  }

  List<Range> parseRanges(String input) {
    List<Range> ranges = [];

    void insertRange(Range range) {
      for (int i = 0; i < ranges.length; i++) {
        final other = ranges[i];
        if (other.touches(range)) {
          ranges.removeAt(i);
          insertRange(other.union(range));
          return;
        }
        if (range.last < other.first) {
          ranges.insert(i, range);
          return;
        }
      }
      ranges.add(range);
    }

    for (final range in input.lines.map(Range.parse)) {
      insertRange(range);
    }
    return ranges;
  }
}

class Range {
  Range(this.first, this.last);

  final int first;
  final int last;

  static Range parse(String input) {
    final limits = input.split('-').map(int.parse);
    return Range(limits.first, limits.last);
  }

  // Do they overlap or even just have adjacent first and last values.
  bool touches(Range other) =>
        (other.first <= first && first <= other.last + 1)
     || (other.first - 1 <= last && last <= other.last)
     || (first <= other.first && other.first <= last + 1)
     || (first - 1 <= other.last && other.last <= last);

  Range union(Range other) => Range(min(other.first, first), max(other.last, last));
}
