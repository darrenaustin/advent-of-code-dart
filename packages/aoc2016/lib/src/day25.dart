// https://adventofcode.com/2016/day/25

import 'package:aoc/aoc.dart';
import 'package:aoc/util/string.dart';

import 'assembunny.dart';

main() => Day25().solve();

class Day25 extends AdventDay {
  Day25() : super(2016, 25, name: 'Clock Signal');

  @override
  dynamic part1(String input) {
    bool validOutput = false;

    bool Function(int) outputHandler() {
      var expectedOutput = List.generate(10, (i) => i % 2);
      return (value) {
        if (value == expectedOutput.first) {
          expectedOutput = expectedOutput.sublist(1);
          if (expectedOutput.isNotEmpty) {
            return false;
          }
          validOutput = true;
        }
        return true;
      };
    }

    int a = 0;
    while (!validOutput) {
      final machine = Assembunny(input.lines, outputHandler());
      machine.registers['a'] = ++a;
      machine.execute();
    }
    return a;
  }

  @override
  dynamic part2(String input) => AdventDay.lastStarSolution;
}
