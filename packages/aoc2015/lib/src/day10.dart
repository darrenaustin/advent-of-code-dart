// https://adventofcode.com/2015/day/10

import 'package:aoc/aoc.dart';
import 'package:aoc/util/collection.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day10().solve();

class Day10 extends AdventDay {
  Day10() : super(2015, 10, name: 'Elves Look, Elves Say');

  @override
  dynamic part1(String input) => lookAndSay('3113322113', 40).length;

  @override
  dynamic part2(String input) => lookAndSay('3113322113', 50).length;

  static String lookAndSay(String text, int rounds) =>
    iterate(say, text).skip(rounds).first;

  static String say(String text) {
    final buffer = StringBuffer();
    String runChar = text[0];
    int runStart = 0;
    text.chars.forEachIndexed((index, ch) {
      if (runChar != ch) {
        buffer.write(index - runStart);
        buffer.write(runChar);
        runChar = ch;
        runStart = index;
      }
    });
    buffer.write(text.length - runStart);
    buffer.write(text[text.length - 1]);
    return buffer.toString();
  }

  // More concise, but twice as slow as the above implementation:
  //
  // static String say(String text) => text
  //   .chars
  //   .slicesWhere(isNotEqual)
  //   .map((g) => [g.length, g.first])
  //   .flattened
  //   .join();
}
