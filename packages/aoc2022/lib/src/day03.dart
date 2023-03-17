// https://adventofcode.com/2022/day/3

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day03().solve();

class Day03 extends AdventDay {
  Day03() : super(
    2022, 3, name: 'Rucksack Reorganization',
    solution1: 7821, solution2: 2752,
  );

  @override
  dynamic part1(String input) =>
    input
      .lines
      .map(compartments)
      .map(commonItem)
      .map(priority)
      .sum;

  @override
  dynamic part2(String input) =>
    input
      .lines
      .slices(3)
      .map(commonItem)
      .map(priority)
      .sum;

  Iterable<String> compartments(String rucksack) {
    final int middle = rucksack.length ~/ 2;
    return [
      rucksack.substring(0, middle),
      rucksack.substring(middle),
    ];
  }

  String commonItem(Iterable<String> sacks) =>
    sacks
      .skip(1)
      .fold<Set<String>>(
        chars(sacks.first),
        (Set<String> common, String sack) => common.intersection(chars(sack))
      )
      .first;

  Set<String> chars(String s) => { ...s.split('') };

  final int lowerA = 'a'.codeUnitAt(0);
  final int upperA = 'A'.codeUnitAt(0);

  int priority(String s) =>
    (s.contains(RegExp(r'[a-z]')))
      ? s.codeUnitAt(0) - lowerA + 1
      : s.codeUnitAt(0) - upperA + 27;
}
