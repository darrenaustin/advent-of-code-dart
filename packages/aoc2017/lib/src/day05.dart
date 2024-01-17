// https://adventofcode.com/2017/day/5

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';

main() => Day05().solve();

class Day05 extends AdventDay {
  Day05() : super(2017, 5, name: 'A Maze of Twisty Trampolines, All Alike');

  @override
  dynamic part1(String input) {
    final maze = input.lines.map(int.parse).toList();
    int steps = 0;
    int pos = 0;
    while (0 <= pos && pos < maze.length) {
      final jump = maze[pos];
      maze[pos]++;
      pos += jump;
      steps++;
    }
    return steps;
  }

  @override
  dynamic part2(String input) {
    final maze = input.lines.map(int.parse).toList();
    int steps = 0;
    int pos = 0;
    while (0 <= pos && pos < maze.length) {
      final jump = maze[pos];
      maze[pos] = jump >= 3 ? jump - 1 : jump + 1;
      pos += jump;
      steps++;
    }
    return steps;
  }
}
