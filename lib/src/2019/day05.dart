// https://adventofcode.com/2019/day/5

import '../../day.dart';
import 'intcode.dart';

class Day05 extends AdventDay {
  Day05() : super(2019, 5, solution1: 9025675, solution2: 11981754);

  @override
  dynamic part1() => diagnosticCode(1);

  @override
  dynamic part2() => diagnosticCode(5);

  int diagnosticCode(int systemId) {
    final output = <int>[];
    final machine = Intcode.from(
      program: inputData(),
      input: [systemId],
      output: output
    );
    while (!machine.execute()) {}
    return output.last;
  }
}
