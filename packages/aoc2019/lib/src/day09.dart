// https://adventofcode.com/2019/day/9

import 'package:aoc/aoc.dart';

import 'intcode.dart';

main() => Day09().solve();

class Day09 extends AdventDay {
  Day09() : super(
    2019, 9, name: 'Sensor Boost',
    solution1: 3063082071, solution2: 81348,
  );

  @override
  dynamic part1(String input) => keycode(input, 1);

  @override
  dynamic part2(String input) => keycode(input, 2);

  int keycode(String program, int input) {
    final machine = Intcode.from(program: program, input: [input]);
    while (!machine.execute()) {}
    return machine.output.single;
  }
}
