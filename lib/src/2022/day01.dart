// https://adventofcode.com/2022/day/1

import 'package:advent_of_code_dart/src/util/comparison.dart';
import 'package:collection/collection.dart';

import '../../day.dart';

class Day01 extends AdventDay {
  Day01() : super(2022, 1, solution1: 67622, solution2: 201491);

  @override
  dynamic part1() {
    return inputCalories().max;
  }

  @override
  dynamic part2() {
    return (inputCalories()..sort(numMaxComparator)).take(3).sum;
  }

  List<int> inputCalories() {
    return inputData()
      .split('\n\n')
      .map((String group) => group
        .split('\n')
        .map(int.parse)
        .sum)
      .toList();
  }
}
