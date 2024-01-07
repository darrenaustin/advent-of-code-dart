// https://adventofcode.com/2016/day/19

import 'dart:collection';

import 'package:aoc/aoc.dart';
import 'package:aoc/util/range.dart';
import 'package:collection/collection.dart';

main() => Day19().solve();

class Day19 extends AdventDay {
  Day19() : super(2016, 19, name: 'An Elephant Named Joseph');

  @override
  dynamic part1(String input) {
    final numElves = int.parse(input);
    List<int> elves = range(1, numElves + 1).toList();
    while (elves.length > 1) {
      final bool wrapAround = elves.length.isOdd;
      final nextRound = <int>[];
      for (int i = wrapAround ? 2 : 0; i < elves.length; i += 2) {
        nextRound.add(elves[i]);
      }
      elves = nextRound;
    }
    return elves.first;
  }

  @override
  dynamic part2(String input) {
    final numElves = int.parse(input);
    final mid = numElves ~/ 2 + 1;
    final right = ListQueue<int>.from(rangeinc(1, mid));
    final left = ListQueue<int>.from(range(numElves, mid));
    while (right.isNotEmpty && left.isNotEmpty) {
      if (right.length > left.length) {
        right.removeLast();
      } else {
        left.removeLast();
      }
      left.addFirst(right.removeFirst());
      right.addLast(left.removeLast());
    }
    return right.firstOrNull ?? left.first;
  }
}
