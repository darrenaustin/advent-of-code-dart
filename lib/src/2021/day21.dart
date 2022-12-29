// https://adventofcode.com/2021/day/21

import 'package:aoc/aoc.dart';
import 'package:collection/collection.dart';

class Day21 extends AdventDay {
  Day21() : super(2021, 21, solution1: 853776);

  @override
  dynamic part1() {
    final lines = inputDataLines();
    final p1 = lines[0].split(' ');
    final p2 = lines[1].split(' ');

    final pos = [int.parse(p1[4]), int.parse(p2[4])];
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
  dynamic part2() {
  }
}

class DeterministicDie {
  int numRolls = 0;
  int value = 1;

  int roll() {
    final result = value;
    value = (value % 100) + 1;
    numRolls++;
    return result;
  }

  int roll3() {
    return roll() + roll() + roll();
  }
}
