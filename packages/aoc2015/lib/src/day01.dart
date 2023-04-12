// https://adventofcode.com/2015/day/1

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day01().solve();

class Day01 extends AdventDay {
  Day01() : super(2015, 1, name: 'Not Quite Lisp');

  @override
  dynamic part1(String input) => input
    .chars
    .map((dir) => dir == '(' ? 1 : -1)
    .sum;

  @override
  dynamic part2(String input) {
    int floor = 0;
    int position = 0;
    input.chars.forEachWhile((dir) {
      floor += (dir == '(') ? 1 : -1;
      position += 1;
      return floor >= 0;
    });
    return position;
  }
}
