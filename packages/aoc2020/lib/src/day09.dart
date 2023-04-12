// https://adventofcode.com/2020/day/9

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';

main() => Day09().solve();

class Day09 extends AdventDay {
  Day09() : super(2020, 9, name: 'Encoding Error');

  @override
  dynamic part1(String input, [int preambleLength = 25]) =>
    firstInvalidNum(parseMessage(input), preambleLength);

  @override
  dynamic part2(String input, [int preambleLength = 25]) {
    final message = parseMessage(input);
    return findWeakness(message, firstInvalidNum(message, preambleLength)!);
  }

  List<int> parseMessage(String input) =>
    input.lines.map(int.parse).toList();

  int? firstInvalidNum(List<int> nums, int preambleLength) {
    bool validSum(int sum, Set<int> previous) {
      for (final pair1 in previous) {
        final pair2 = sum - pair1;
        if (previous.contains(pair2) && pair1 != pair2) {
          return true;
        }
      }
      return false;
    }

    var previous = nums.sublist(0, preambleLength).toSet();
    for (var i = preambleLength; i < nums.length; i++) {
      if (validSum(nums[i], previous)) {
        // Remove the oldest from the set and add the current num to it
        previous.remove(nums[i - preambleLength]);
        previous.add(nums[i]);
      } else {
        return nums[i];
      }
    }
    return null;
  }

  int findWeakness(List<int> nums, int target) {
    for (var start = 0; start < nums.length; start++) {
      var sumLeft = target - nums[start];
      for (var end = start + 1; start < nums.length && sumLeft > 0; end++) {
        sumLeft -= nums[end];
        if (sumLeft == 0) {
          // Found it
          final range = nums.sublist(start, end + 1)..sort();
          return range.first + range.last;
        }
      }
    }
    return -1;
  }
}
