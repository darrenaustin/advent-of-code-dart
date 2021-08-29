// https://adventofcode.com/2015/day/8

import '../../day.dart';
import '../util/collection.dart';

class Day08 extends AdventDay {
  Day08() : super(2015, 8, solution1: 1371, solution2: 2117);

  @override
  dynamic part1() {
    return inputDataLines()
        .map((String s) => s.length - unescape(s).length)
        .sum();
  }

  @override
  dynamic part2() {
    return inputDataLines()
        .map((String s) => escape(s).length - s.length)
        .sum();
  }

  String escape(String text) {
    return '"${text.replaceAll(r'\', r'\\').replaceAll(r'"', r'\"')}"';
  }

  String unescape(String text) {
    return text
        .substring(1, text.length - 1)
        .replaceAll(r'\"', '"')
        .replaceAll(RegExp(r'\\x[0-9a-f][0-9a-f]'), '*')
        .replaceAll(r'\\', r'\');
  }
}
