// https://adventofcode.com/2019/day/2

import '../../day.dart';
import 'intcode.dart';

class Day02 extends AdventDay {
  Day02() : super(2019, 2, solution1: 6087827, solution2: 5379);

  @override
  dynamic part1() {
    return executeProgram(inputData(), 12, 2);
  }

  @override
  dynamic part2() {
    final program = inputData();
    final targetResult = 19690720;
    for (var noun = 0; noun < 100; noun++) {
      for (var verb = 0; verb < 100; verb++) {
        if (executeProgram(program, noun, verb) == targetResult) {
          return 100 * noun + verb;
        }
      }
    }
    throw Exception('No noun, verb combination yielded $targetResult');
  }

  int executeProgram(String program, int noun, int verb) {
    final machine = Intcode.from(program: program)
      ..[1] = noun
      ..[2] = verb;
    while (!machine.execute()) {}
    return machine[0];
  }
}
