// https://adventofcode.com/2019/day/5

import 'package:aoc/aoc.dart';

import 'intcode.dart';

main() => Day05().solve();

class Day05 extends AdventDay {
  Day05() : super(
    2019, 5, name: 'Cryostasis',
    solution1: 9025675, solution2: 11981754,
  );

  @override
  dynamic part1(String input) => diagnosticCode(1, input);

  @override
  dynamic part2(String input) => diagnosticCode(5, input);

  int diagnosticCode(int systemId, String program) {
    final output = <int>[];
    final machine = Intcode.from(
      program: program,
      input: [systemId],
      output: output
    );
    while (!machine.execute()) {}
    return output.last;
  }
}
