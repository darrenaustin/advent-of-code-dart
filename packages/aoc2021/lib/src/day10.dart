// https://adventofcode.com/2021/day/10

import 'package:aoc/aoc.dart';

class Day10 extends AdventDay {
  Day10() : super(2021, 10, solution1: 318081, solution2: 4361305341);

  static const pairs = {
    '(': ')',
    '[': ']',
    '{': '}',
    '<': '>',
  };

  static const corruptScore = {
    ')': 3,
    ']': 57,
    '}': 1197,
    '>': 25137,
  };

  static const incompleteScore = {
    ')': 1,
    ']': 2,
    '}': 3,
    '>': 4,
  };

  @override
  dynamic part1() {
    int score = 0;
    for (final line in inputDataLines()) {
      List stack = [];
      for (final c in line.split('')) {
        if (pairs.containsKey(c)) {
          stack.add(pairs[c]);
        } else {
          if (stack.last == c) {
            stack.removeLast();
          } else {
            score += corruptScore[c]!;
            break;
          }
        }
      }
    }
    return score;
  }

  @override
  dynamic part2() {
    List<int> scores= [];
    for (final line in inputDataLines()) {
      List stack = [];
      bool corrupted = false;
      for (final c in line.split('')) {
        if (pairs.containsKey(c)) {
          stack.insert(0, pairs[c]);
        } else {
          if (stack.first == c) {
            stack.removeAt(0);
          } else {
            corrupted = true;
            break;
          }
        }
      }
      if (!corrupted) {
        int lineScore = 0;
        for (int i = 0; i < stack.length; i++) {
          lineScore = lineScore * 5 + incompleteScore[stack[i]]!;
        }
        scores.add(lineScore);
      }
    }
    scores.sort();
    return scores[scores.length ~/ 2];
  }
}
