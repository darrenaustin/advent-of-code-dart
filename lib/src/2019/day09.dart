// https://adventofcode.com/2019/day/9

import '../../day.dart';
import 'intcode.dart';

class Day09 extends AdventDay {
  Day09() : super(2019, 9, solution1: 3063082071, solution2: 81348);

  @override
  dynamic part1() => keycode(1);

  @override
  dynamic part2() => keycode(2);

  int keycode(int input) {
    final machine = Intcode.from(program: inputData(), input: [input]);
    while (!machine.execute()) {}
    return machine.output.single;
  }
}
