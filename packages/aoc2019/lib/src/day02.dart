// https://adventofcode.com/2019/day/2

import 'package:aoc/aoc.dart';

import 'intcode.dart';

main() => Day02().solve();

class Day02 extends AdventDay {
  Day02() : super(2019, 2, name: '1202 Program Alarm');

  @override
  dynamic part1(String input) => executeProgram(input, 12, 2);

  @override
  dynamic part2(String input) {
    final targetResult = 19690720;
    for (int noun = 0; noun < 100; noun++) {
      for (int verb = 0; verb < 100; verb++) {
        if (executeProgram(input, noun, verb) == targetResult) {
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
