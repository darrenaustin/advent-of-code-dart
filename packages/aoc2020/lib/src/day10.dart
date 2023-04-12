// https://adventofcode.com/2020/day/10

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';

main() => Day10().solve();

class Day10 extends AdventDay {
  Day10() : super(2020, 10, name: 'Adapter Array');

  @override
  dynamic part1(String input) {
    final adapters = parseAdapters(input);
    final diffCounts = <int, int>{};

    int current = 0;
    for (final adapter in adapters) {
      final diff = adapter - current;
      diffCounts[diff] = (diffCounts[diff] ?? 0) + 1;
      current = adapter;
    }
    // Add the final 3 jolt for the device
    diffCounts[3] = (diffCounts[3] ?? 0) + 1;
    final oneJolts = diffCounts[1] ?? 0;
    final threeJolts = diffCounts[3] ?? 0;
    return oneJolts * threeJolts;
  }

  @override
  dynamic part2(String input) => numArrangements(parseAdapters(input));

  List<int> parseAdapters(String input) =>
    input
      .lines
      .map(int.parse)
      .toList()
      ..add(0)
      ..sort();

  int numArrangements(List<int> adapters, [int fromIndex = 0, Map<int, int>? cache]) {
    cache ??= <int, int>{};
    if (cache.containsKey(fromIndex)) {
      return cache[fromIndex]!;
    }
    if (fromIndex == adapters.length - 1) {
      return 1;
    }
    var arrangements = 0;
    var nextIndex = fromIndex + 1;
    while (nextIndex < adapters.length && adapters[nextIndex] - adapters[fromIndex] <= 3) {
      arrangements += numArrangements(adapters, nextIndex, cache);
      nextIndex++;
    }
    cache[fromIndex] = arrangements;
    return arrangements;
  }
}
