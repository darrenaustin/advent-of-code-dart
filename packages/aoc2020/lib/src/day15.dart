// https://adventofcode.com/2020/day/15

import 'package:aoc/aoc.dart';
import 'package:aoc/util/collection.dart';

main() => Day15().solve();

class Day15 extends AdventDay {
  Day15() : super(
    2020, 15, name: 'Rambunctious Recitation',
    solution1: 694, solution2: 21768614,
  );

  @override
  dynamic part1(String input) => numberSpoken(parseNumbers(input), 2020);

  @override
  dynamic part2(String input) => numberSpoken(parseNumbers(input), 30000000);

  Iterable<int> parseNumbers(String input) => input.split(',').map(int.parse);

  int numberSpoken(Iterable<int> starting, int turnNumber) {
    final lastSpoken = <int, int>{};
    int turn = 1;
    int current = starting.first;
    for (final value in starting.skip(1)) {
      lastSpoken[current] = turn++;
      current = value;
    }
    while (turn < turnNumber) {
      final age = turn - lastSpoken.getOrElse(current, turn);
      lastSpoken[current] = turn;
      current = age;
      turn++;
    }
    return current;
  }
}
