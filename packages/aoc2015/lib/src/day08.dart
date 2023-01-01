// https://adventofcode.com/2015/day/8

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day08().solve();

class Day08 extends AdventDay {
  Day08() : super(
    2015, 8, name: 'Matchsticks',
    solution1: 1371, solution2: 2117,
  );

  @override
  dynamic part1(String input) => input
    .lines
    .map((s) => s.length - unescape(s).length)
    .sum;

  @override
  dynamic part2(String input) => input
    .lines
    .map((s) => escape(s).length - s.length)
    .sum;

  static String escape(String text) =>
   '"${text.replaceAll(r'\', r'\\').replaceAll(r'"', r'\"')}"';

  static String unescape(String text) => text
    .substring(1, text.length - 1)
    .replaceAll(r'\"', '"')
    // Should actually replace with the ASCII char, but for length we don't
    // need the actual letter, just a placeholder.
    .replaceAll(RegExp(r'\\x[0-9a-f][0-9a-f]'), '*')
    .replaceAll(r'\\', r'\');
}
