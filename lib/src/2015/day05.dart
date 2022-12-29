// https://adventofcode.com/2015/day/5

import 'package:aoc/aoc.dart';
import 'package:aoc/util/collection.dart';

class Day05 extends AdventDay {
  Day05() : super(2015, 5, solution1: 238, solution2: 69);

  @override
  dynamic part1() {
    bool niceString(String text) {
      return
        RegExp(r'[aeiou]').allMatches(text).length >= 3 &&
        RegExp(r'(.)\1').hasMatch(text) &&
        !RegExp(r'ab|cd|pq|xy').hasMatch(text);
    }

    return inputDataLines().quantify(niceString);
  }

  @override
  dynamic part2() {
    bool niceString(String text) {
      return
        RegExp(r'(..).*\1').hasMatch(text) &&
        RegExp(r'(.).\1').hasMatch(text);
    }

    return inputDataLines().quantify(niceString);
  }
}
