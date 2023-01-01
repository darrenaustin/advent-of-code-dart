// https://adventofcode.com/2015/day/12

import 'dart:convert';

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day12().solve();

class Day12 extends AdventDay {
  Day12() : super(
    2015, 12, name: 'JSAbacusFramework.io',
    solution1: 191164, solution2: 87842,
  );

  @override
  dynamic part1(String input) => _sumOfInts(input);

  @override
  dynamic part2(String input) {
    final dynamic doc = 
      jsonDecode(input,
        reviver: (key, value) =>
          (value is Map && value.values.any((v) => v == 'red')) ? 0 : value
      );
    return _sumOfInts(doc.toString());
  }

  static final _numberPattern = RegExp(r'-?\d+');

  static int _sumOfInts(String text) {
    return _numberPattern
      .allStringMatches(text)
      .map(int.parse)
      .sum;
  }
}
