// https://adventofcode.com/2021/day/10

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day10().solve();

class Day10 extends AdventDay {
  Day10() : super(
    2021, 10, name: 'Syntax Scoring',
    solution1: 318081, solution2: 4361305341,
  );

  static const pairs = {
    '(': ')',
    '[': ']',
    '{': '}',
    '<': '>',
  };

  @override
  dynamic part1(String input) => input
    .lines
    .map(corruptedScore)
    .whereNotNull()
    .sum;

  @override
  dynamic part2(String input) {
    final scores = input
      .lines
      .map(incompleteScore)
      .whereNotNull()
      .toList()
      ..sort();
    return scores[scores.length ~/ 2];
  }

  int? corruptedScore(String line) {
    const scores = {
      ')': 3,
      ']': 57,
      '}': 1197,
      '>': 25137,
    };
    List openStack = [];
    for (final c in line.chars) {
      if (pairs.containsKey(c)) {
        openStack.add(pairs[c]);
      } else {
        if (openStack.last == c) {
          openStack.removeLast();
        } else {
          return scores[c]!;
        }
      }
    }
    return null;
  }

  int? incompleteScore(String line) {
    const scores = {
      ')': 1,
      ']': 2,
      '}': 3,
      '>': 4,
    };
    final openStack = <String>[];
    for (final c in line.chars) {
      if (pairs.containsKey(c)) {
        openStack.add(pairs[c]!);
      } else {
        if (openStack.last == c) {
          openStack.removeLast();
        } else {
          // Corrupted, so ignore
          return null;
        }
      }
    }
    return openStack
      .reversed
      .fold<int>(0, (score, closer) => score * 5 + scores[closer]!);
  }
}
