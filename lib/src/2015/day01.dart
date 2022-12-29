// https://adventofcode.com/2015/day/1

import 'package:aoc/aoc.dart';

class Day01 extends AdventDay {
  Day01() : super(2015, 1, solution1: 138, solution2: 1771);

  @override
  dynamic part1() {
    final List<String> instructions = inputData().split('');
    int floor = 0;
    for (final String instruction in instructions) {
      floor += (instruction == '(') ? 1 : -1;
    }
    return floor;
  }

  @override
  dynamic part2() {
    final List<String> instructions = inputData().split('');
    int floor = 0;
    int position = 1;
    for (final String instruction in instructions) {
      floor += (instruction == '(') ? 1 : -1;
      if (floor < 0) {
        return position;
      }
      position++;
    }
  }
}
