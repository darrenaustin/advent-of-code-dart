// https://adventofcode.com/2023/day/6

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';

main() => Day06().solve();

class Day06 extends AdventDay {
  Day06() : super(2023, 6, name: 'Wait For It');

  static final numRegex = RegExp(r'\d+');

  @override
  dynamic part1(String input) {
    final inputLines = input.lines;
    final times =
        numRegex.allStringMatches(inputLines.first).map(int.parse).toList();
    final distances =
        numRegex.allStringMatches(inputLines.last).map(int.parse).toList();

    var winningProduct = 1;
    for (int i = 0; i < times.length; i++) {
      winningProduct *= waysToBeat(times[i], distances[i]);
    }
    return winningProduct;
  }

  @override
  dynamic part2(String input) {
    final inputLines = input.lines;
    final time =
        int.parse(numRegex.allStringMatches(inputLines.first).join(''));
    final distance =
        int.parse(numRegex.allStringMatches(inputLines.last).join(''));

    return waysToBeat(time, distance);
  }

  int waysToBeat(int duration, int maxDistance) {
    var ways = 0;
    for (int press = 0; press < duration; press++) {
      final distance = press * (duration - press);
      if (distance > maxDistance) {
        ways++;
      }
    }
    return ways;
  }
}
