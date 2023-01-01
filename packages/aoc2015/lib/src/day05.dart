// https://adventofcode.com/2015/day/5

import 'package:aoc/aoc.dart';
import 'package:aoc/util/collection.dart';
import 'package:aoc/util/string.dart';

main() => Day05().solve();

class Day05 extends AdventDay {
  Day05() : super(
    2015, 5, name: "Doesn't He Have Intern-Elves For This?",
    solution1: 238, solution2: 69,
   );

  @override
  dynamic part1(String input) => input.lines.quantify(niceStringPart1);

  @override
  dynamic part2(String input) => input.lines.quantify(niceStringPart2);

  static final _threeVowels = RegExp(r'.*[aeiou].*[aeiou].*[aeiou].*');
  static final _atLeastOneDupe = RegExp(r'(.)\1');
  static final _hasNaughtyPairs = RegExp(r'ab|cd|pq|xy');

  static bool niceStringPart1(String text) {
    return
      _threeVowels.hasMatch(text) &&
      _atLeastOneDupe.hasMatch(text) &&
      !_hasNaughtyPairs.hasMatch(text);
  }

  static final _hasPairOfDupes = RegExp(r'(..).*\1');
  static final _pairSandwich = RegExp(r'(.).\1');

  static bool niceStringPart2(String text) {
    return
      _hasPairOfDupes.hasMatch(text) &&
      _pairSandwich.hasMatch(text);
  }
}
