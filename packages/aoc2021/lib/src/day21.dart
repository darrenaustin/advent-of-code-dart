// https://adventofcode.com/2021/day/21

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';
import 'package:collection/collection.dart';

main() => Day21().solve();

class Day21 extends AdventDay {
  Day21() : super(
    2021, 21, name: 'Dirac Dice',
    solution1: 853776,
  );

  @override
  dynamic part1(String input) {
    final lines = input.lines;
    final p1 = int.parse(lines[0].split(': ')[1]);
    final p2 = int.parse(lines[1].split(': ')[1]);

    final pos = [p1, p2];
    final score = [0, 0];
    final die = DeterministicDie();
    int player = 0;
    bool playerWon = false;
    while (!playerWon) {
      pos[player] = (pos[player] + die.roll3() - 1) % 10 + 1;
      score[player] += pos[player];
      playerWon = score[player] >= 1000;
      player = (player + 1) % 2;
    }
    return score.min * die.numRolls;
  }

  @override
  dynamic part2(String input) {
  }
}

class DeterministicDie {
  int numRolls = 0;
  int _current = 1;

  int roll() {
    final result = _current;
    _current = (_current % 100) + 1;
    numRolls++;
    return result;
  }

  int roll3() => roll() + roll() + roll();
}
