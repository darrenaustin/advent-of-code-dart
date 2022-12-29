// https://adventofcode.com/2015/day/4

import 'dart:convert';

import 'package:aoc/aoc.dart';
import 'package:crypto/crypto.dart';

class Day04 extends AdventDay {
  Day04() : super(2015, 4, solution1: 117946, solution2: 3938038);

  @override
  dynamic part1() {
    return searchMD5(inputData(), '00000');
  }

  @override
  dynamic part2() {
    final int part1Solution = solution1 as int;
    return searchMD5(inputData(), '000000', part1Solution);
  }

  String textMD5(String text) {
    return md5.convert(utf8.encode(text)).toString();
  }

  int searchMD5(String key, String prefix, [int startTestNum = -1]) {
    int testNum = startTestNum;
    while (!textMD5(key + testNum.toString()).startsWith(prefix)) {
      testNum++;
    }
    return testNum;
  }
}
