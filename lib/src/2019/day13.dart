// https://adventofcode.com/2019/day/13

import '../../day.dart';
import '../util/collection.dart';
import '../util/vec2.dart';
import 'intcode.dart';

const int empty = 0;
const int wall = 1;
const int block = 2;
const int paddle = 3;
const int ball = 4;

class Day13 extends AdventDay {
  Day13() : super(2019, 13, solution1: 333, solution2: 16539);

  @override
  dynamic part1() {
    final machine = Intcode.from(program: inputData());
    while (!machine.execute()) {}
    return machine.output.slices(3)
      .where((p) => p.last == block)
      .length;
  }

  @override
  dynamic part2() {
    final machine = Intcode.from(program: inputData());
    int score = 0;
    Vec2 ballPos = Vec2.zero;
    Vec2 paddlePos = Vec2.zero;

    machine[0] = 2;
    while (!machine.execute() || machine.output.isNotEmpty) {
      machine.output.slices(3).map((p) => p.toList()).forEach((command) {
        if (command[0] == -1 && command[1] == 0) {
          score = command[2];
        } else {
          switch (command[2]) {
            case ball:
              ballPos = Vec2.int(command[0], command[1]);
              break;
            case paddle:
              paddlePos = Vec2.int(command[0], command[1]);
              break;
          }
        }
      });
      machine.output.clear();
      machine.input.add(ballPos.xInt.compareTo(paddlePos.xInt));
    }
    return score;
  }
}
