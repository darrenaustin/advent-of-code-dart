// https://adventofcode.com/2022/day/4

import '../../day.dart';

class Day04 extends AdventDay {
  Day04() : super(2022, 4, solution1: 550, solution2: 931);

  @override
  dynamic part1() {
    return inputDataLines()
      .map(RangePair.from)
      .where(RangePair.contained)
      .length;
  }

  @override
  dynamic part2() {
    return inputDataLines()
      .map(RangePair.from)
      .where(RangePair.intersecting)
      .length;
  }
}

class RangePair {
  RangePair(this.first, this.second);

  factory RangePair.from(String input) {
    final ranges = input.split(',');
    return RangePair(Range.from(ranges.first), Range.from(ranges.last));
  }

  final Range first;
  final Range second;

  static bool contained(RangePair rp) =>
    rp.first.contains(rp.second) || rp.second.contains(rp.first);

  static bool intersecting(RangePair rp) =>
   rp.first.intersects(rp.second) || rp.second.intersects(rp.first);
}

class Range {
  Range(this.start, this.end);

  factory Range.from(String input) {
    final values = input.split('-').map(int.parse);
    return Range(values.first, values.last);
  }

  final int start;
  final int end;

  bool contains(Range other) => start <= other.start && end >= other.end;

  bool intersects(Range other) =>
    (other.start <= start && start <= other.end) ||
    (other.start <= end && end <= other.end);
}
