// https://adventofcode.com/2015/day/12

import 'dart:convert';

import 'package:aoc/aoc.dart';
import 'package:collection/collection.dart';

class Day12 extends AdventDay {
  Day12() : super(2015, 12, solution1: 191164, solution2: 87842);

  @override
  dynamic part1() {
    return sumOfInts(inputData());
  }

  @override
  dynamic part2() {
    final dynamic doc = jsonDecode(inputData(),
      reviver: (Object? key, Object? value) =>
        (value is Map && value.values.any((dynamic v) => v == 'red')) ? 0 : value);
    return sumOfInts(doc.toString());
  }

  int sumOfInts(String text) {
    return RegExp(r'(-?\d+)')
        .allMatches(text)
        .map((RegExpMatch m) => int.parse(m.group(0)!))
        .sum;
  }
}
