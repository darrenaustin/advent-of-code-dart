// https://adventofcode.com/2015/day/17

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day17().solve();

class Day17 extends AdventDay {
  Day17() : super(
    2015, 17, name: 'No Such Thing as Too Much',
    solution1: 1304, solution2: 18,
  );

  @override
  dynamic part1(String input) => 
    containersThatSumTo(containers(input), 150).length;

  @override
  dynamic part2(String input) => numMinFill(containers(input), 150);

  Iterable<int> containers(String input) =>
    input.lines.map(int.parse).sorted(Comparable.compare);

  // Returns all combinations of containers that can fit the sum.
  // Assumes the containers are storted.
  static Iterable<Iterable<int>> containersThatSumTo(
    Iterable<int> containers, int sum
  ) sync* {
    if (sum == 0) {
      yield <int>[];
    } else if (containers.isNotEmpty) {
      final n = containers.first;
      final rest = containers.skip(1);
      if (n <= sum) {
        for (final s in containersThatSumTo(rest, sum - n)) {
          yield [n, ...s];
        }
      }
      for (final s in containersThatSumTo(rest, sum)) {
        yield s;
      }
    }
  }

  static int numMinFill(Iterable<int> containers, int sum) {
    final allCombinations = containersThatSumTo(containers, sum);
    final minContainersUsed = allCombinations.map((c) => c.length).min;
    return allCombinations.where((c) => c.length == minContainersUsed).length;
  }
}
