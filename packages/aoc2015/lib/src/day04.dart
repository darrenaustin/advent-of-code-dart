// https://adventofcode.com/2015/day/4

import 'dart:convert';

import 'package:aoc/aoc.dart';
import 'package:crypto/crypto.dart';

main() => Day04().solve();

class Day04 extends AdventDay {
  Day04() : super(2015, 4, name: 'The Ideal Stocking Stuffer');

  @override
  dynamic part1(String input) => searchMD5(input, '00000');

  @override
  dynamic part2(String input) => searchMD5(input, '000000', answer1 as int);

  String textMD5(String text) => md5.convert(utf8.encode(text)).toString();

  int searchMD5(String key, String prefix, [int startTestNum = -1]) {
    int testNum = startTestNum;
    while (!textMD5(key + testNum.toString()).startsWith(prefix)) {
      testNum++;
    }
    return testNum;
  }
}
