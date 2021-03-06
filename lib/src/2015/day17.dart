// https://adventofcode.com/2015/day/17

import '../../day.dart';
import '../util/collection.dart';

class Day17 extends AdventDay {
  Day17() : super(2015, 17, solution1: 1304, solution2: 18);

  @override
  dynamic part1() {
    return sumTo(inputContainers(), 150).length;
  }

  @override
  dynamic part2() {
    final Iterable<Iterable<int>> allCombinations = sumTo(inputContainers(), 150);
    final int minContainersUsed = allCombinations.map((Iterable<int> c) => c.length).min();
    return allCombinations.where((Iterable<int> c) => c.length == minContainersUsed).length;
  }

  Iterable<int> inputContainers() {
    return inputDataLines().map(int.parse).toList()..sort();
  }

  Iterable<Iterable<int>> sumTo(Iterable<int> sortedValues, int sum) sync* {
    if (sum == 0) {
      yield <int>[];
    } else if (sortedValues.isNotEmpty) {
      final int n = sortedValues.first;
      final Iterable<int> rest = sortedValues.skip(1);
      if (n <= sum) {
        for (final Iterable<int> s in sumTo(rest, sum - n)) {
          yield <int>[n, ...s];
        }
      }
      for (final Iterable<int> s in sumTo(rest, sum)) {
        yield s;
      }
    }
  }
}
