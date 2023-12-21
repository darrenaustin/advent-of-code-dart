// https://adventofcode.com/2018/day/5

import 'dart:math';

import 'package:aoc/aoc.dart';
import 'package:aoc/util/math.dart';
import 'package:aoc/util/string.dart';

main() => Day05().solve();

class Day05 extends AdventDay {
  Day05() : super(2018, 5, name: 'Alchemical Reduction');

  @override
  dynamic part1(String input) => fullyReact(input).length;

  @override
  dynamic part2(String input) {
    var minLength = maxInt;
    final chars = input.toLowerCase().chars.toSet();
    for (final c in chars) {
      final regex = RegExp('$c|${c.toUpperCase()}');
      final redacted = input.replaceAll(regex, '');
      final reacted = fullyReact(redacted);
      minLength = min(reacted.length, minLength);
    }
    return minLength;
  }

  String fullyReact(String input) {
    var done = false;
    while (!done) {
      done = true;
      var i = 0;
      while (i < input.length - 1) {
        final first = input[i];
        final opposite =
            first.isUpperCase() ? first.toLowerCase() : first.toUpperCase();
        if (input[i + 1] == opposite) {
          input = input.replaceRange(i, i + 2, '');
          done = false;
        } else {
          i++;
        }
      }
    }
    return input;
  }
}
