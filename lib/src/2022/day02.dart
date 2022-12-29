// https://adventofcode.com/2022/day/2

import 'package:aoc/aoc.dart';

enum Shape {
  rock(1), paper(2), scissors(3);

  const Shape(this.score);
  final int score;

  static Shape shapeFor(String s) => {
    'A': Shape.rock,
    'B': Shape.paper,
    'C': Shape.scissors,
    'X': Shape.rock,
    'Y': Shape.paper,
    'Z': Shape.scissors,
  }[s]!;

  Shape get beats => {
    Shape.rock: Shape.scissors,
    Shape.paper: Shape.rock,
    Shape.scissors: Shape.paper,
  }[this]!;

  Shape get losesTo => {
    Shape.rock: Shape.paper,
    Shape.paper: Shape.scissors,
    Shape.scissors: Shape.rock,
  }[this]!;
}

enum Result {
  lose(0), draw(3), win(6);

  const Result(this.score);
  final int score;

  static Result desiredResult(String s) => {
    'X': Result.lose,
    'Y': Result.draw,
    'Z': Result.win,
  }[s]!;
}

class Day02 extends AdventDay {
  Day02() : super(2022, 2, solution1: 14531, solution2: 11258);

  @override
  dynamic part1() {
    int sum = 0;
    for (String line in inputDataLines()) {
      final values = line.split(' ');
      sum += score(Shape.shapeFor(values[0]), Shape.shapeFor(values[1]));
    }
    return sum;
  }

  @override
  dynamic part2() {
    int sum = 0;
    for (String line in inputDataLines()) {
      final values = line.split(' ');
      final opponent = Shape.shapeFor(values[0]);
      final player = playFor(opponent, Result.desiredResult(values[1]));
      sum += score(opponent, player);
    }
    return sum;
  }

  Result round(Shape opponent, Shape player) {
    return opponent == player
      ? Result.draw
      : player.beats == opponent ? Result.win : Result.lose;
  }

  int score(Shape opponent, Shape player) {
    return player.score + round(opponent, player).score;
  }

  Shape playFor(Shape opponent, Result result) {
    switch (result) {
      case Result.lose:
        return opponent.beats;
      case Result.draw:
        return opponent;
      case Result.win:
        return opponent.losesTo;
    }
  }
}
