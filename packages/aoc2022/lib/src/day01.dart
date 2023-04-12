// https://adventofcode.com/2022/day/1

import 'package:aoc/aoc.dart';
import 'package:aoc/util/comparison.dart';
import 'package:collection/collection.dart';

main() => Day01().solve();

class Day01 extends AdventDay {
  Day01() : super(2022, 1, name: 'Calorie Counting');

  @override
  dynamic part1(String input) => parseCalories(input).max;

  @override
  dynamic part2(String input) =>
    (parseCalories(input)..sort(numMaxComparator))
      .take(3)
      .sum;

  List<int> parseCalories(String input) {
    return input
      .split('\n\n')
      .map((String group) => group
        .split('\n')
        .map(int.parse)
        .sum)
      .toList();
  }
}
