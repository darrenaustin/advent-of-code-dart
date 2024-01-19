// https://adventofcode.com/2023/day/12

import 'package:aoc/aoc.dart';
import 'package:aoc/util/collection.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day12().solve();

class Day12 extends AdventDay {
  Day12() : super(2023, 12, name: 'Hot Springs');

  @override
  dynamic part1(String input) => input.lines.map(parseRow).map(numWays).sum;

  @override
  dynamic part2(String input) {
    return input.lines.map((l) => parseRow(l, 5)).map(numWays).sum;
  }

  (String springs, List<int> runs) parseRow(String input, [int foldTimes = 1]) {
    final parts = input.split(' ');
    final springs = parts[0].repeat(foldTimes, '?');
    final damagedRuns =
        parts[1].split(',').map(int.parse).toList().repeat(foldTimes);
    return (springs, damagedRuns);
  }

  // I had a very slow solution to this, but found a much
  // cleaner solution from:
  //
  // https://www.reddit.com/r/adventofcode/comments/18ge41g/comment/kd0ki5t/?utm_source=share&utm_medium=web2x&context=3
  //
  // which I adapted here with a manual cache to make it fast.
  int numWays((String springs, List<int> runs) row) {
    final (springs, runs) = row;

    final cache = <(int, int), int>{};

    int search(int s, int r) {
      final input = (s, r);
      // Returned cached result if we have previously computed it.
      final cachedResult = cache[input];
      if (cachedResult != null) {
        return cachedResult;
      }

      // We have exhausted the spring, so return 1 if we have exhausted
      // the damaged runs.
      if (s >= springs.length) {
        final result = r == runs.length ? 1 : 0;
        cache[input] = result;
        return result;
      }

      int ways = 0;
      final spring = springs[s];

      // Handle operational or unknown spring by skipping to next spring.
      if ('.?'.contains(spring)) {
        ways += search(s + 1, r);
      }

      // Handle damanged or unknown spring
      if ('#?'.contains(spring) &&
          (r < runs.length) &&
          // Spring for the run contains only '#' or '?'
          (s + runs[r] <= springs.length &&
              !springs.substring(s, s + runs[r]).contains('.')) &&
          // Spring for the run isn't followed by a '#'
          (s + runs[r] == springs.length || springs[s + runs[r]] != '#')) {
        // Advance to the next run
        ways += search(s + runs[r] + 1, r + 1);
      }

      cache[input] = ways;
      return ways;
    }

    return search(0, 0);
  }
}
